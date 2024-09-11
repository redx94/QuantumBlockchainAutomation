# aggregator.py
# Aggregates the quantum random numbers from nodes and sends the result to the blockchain
import zmq
from web3 import Web3

def main():
    context = zmq.Context()
    socket = context.socket(zmq.SUB)
    socket.connect("tcp://localhost:5555")
    socket.setsockopt_string(zmq.SUBSCRIBE, "")

    aggregated_results = ""
    num_nodes = 2  # Change this if you have more nodes
    node_data_received = [False] * (num_nodes + 1)

    # Setup Web3 to connect to your Ganache blockchain
    w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))

    # Assuming you deployed a smart contract at this address
    contract_address = 'YOUR_CONTRACT_ADDRESS'
    with open('contract_abi.json', 'r') as abi_file:
        contract_abi = abi_file.read()

    contract = w3.eth.contract(address=contract_address, abi=contract_abi)

    while True:
        message = socket.recv_string()
        print(f"Received: {message}")
        node_id, random_data = message.split(': ')
        node_id = int(node_id.split(' ')[1])
        node_data_received[node_id] = True

        random_bits = random_data.strip("{}").split("'")[1]
        aggregated_results += random_bits

        if all(node_data_received):
            print(f"\n--- Aggregated Results: --- \n{aggregated_results}")

            # Submit to Blockchain
            tx_hash = contract.functions.addEntry(0, aggregated_results).transact({'from': w3.eth.accounts[0]})
            print(f"Submitted transaction: {tx_hash.hex()}")

            aggregated_results = ''
            node_data_received = [False] * (num_nodes + 1)
            print("\n--- Waiting for new data from nodes... ---")

if __name__ == "__main__":
    main()

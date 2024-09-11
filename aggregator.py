import zmq
from web3 import Web3, HTTPProvider
import json

def main():
    # ZeroMQ setup
    context = zmq.Context()
    socket = context.socket(zmq.SUB)
    socket.connect("tcp://localhost:5555")
    socket.setsockopt_string(zmq.SUBSCRIBE, "")  # Subscribe to all messages

    # Blockchain setup
    w3 = Web3(HTTPProvider('http://127.0.0.1:7545'))  # Ganache RPC URL

    # Load contract details from Truffle artifact
    with open('build/contracts/QRNGLedger.json') as f:
        contract_json = json.load(f)
        abi = contract_json['abi']
        contract_address = contract_json['networks']['development']['address']

    # Create the contract instance
    contract = w3.eth.contract(address=contract_address, abi=abi)

    aggregated_results = ''
    num_nodes = 2  # Two nodes
    node_data_received = [False] * (num_nodes + 1)

    while True:
        message = socket.recv_string()
        print(f"Received: {message}")
        node_id, random_data = message.split(': ')
        node_id = int(node_id.split(' ')[1])
        node_data_received[node_id] = True

        random_bits = random_data.strip("{}").split("'")[1]
        aggregated_results += random_bits

        # When all nodes have sent data, submit to blockchain
        if all(node_data_received):
            print(f"\n--- Aggregated Results: --- \n{aggregated_results}")
            try:
                # Send the aggregated random numbers to the blockchain
                tx_hash = contract.functions.addEntry(0, aggregated_results).transact({
                    'from': w3.eth.accounts[0]  # Use the first account from Ganache
                })
                print(f"Submitted transaction to blockchain: {tx_hash.hex()}")
            except Exception as e:
                print(f"Error submitting to blockchain: {e}")

            # Reset for next round
            aggregated_results = ''
            node_data_received = [False] * (num_nodes + 1)
            print("\n--- Waiting for new data from nodes... ---\n")

if __name__ == "__main__":
    main()

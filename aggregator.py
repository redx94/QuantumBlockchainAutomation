# aggregator.py 
# © 2024 Reece Dixon. All Rights Reserved. 
# Proprietary License: This code is licensed under the Reece Dixon Proprietary License.
# Unauthorized copying, distribution, or modification of this code is strictly prohibited.

import zmq
import json
from web3 import Web3

# Connect to local Ethereum blockchain (Ganache)
w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))

# Contract setup
contract_address = "YOUR_DEPLOYED_CONTRACT_ADDRESS"  # Replace with the actual contract address
with open('contract_abi.json', 'r') as abi_file:
    contract_abi = json.load(abi_file)

contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# Ethereum account (use the first one provided by Ganache)
account = w3.eth.accounts[0]

# ZeroMQ Setup
context = zmq.Context()
socket = context.socket(zmq.SUB)
socket.connect("tcp://localhost:5555")  # Adjust as needed
socket.setsockopt_string(zmq.SUBSCRIBE, "")

# Aggregator to collect and submit random data
aggregated_results = ''
num_nodes = 2  # Adjust based on the number of nodes
node_data_received = [False] * (num_nodes + 1)

def submit_to_blockchain(node_id, random_result):
    try:
        tx_hash = contract.functions.addEntry(node_id, random_result).transact({'from': account})
        print(f"Transaction hash: {tx_hash.hex()}")
    except Exception as e:
        print(f"Error submitting to blockchain: {e}")

while True:
    message = socket.recv_string()
    print(f"Received: {message}")
    node_id, random_data = message.split(': ')
    node_id = int(node_id.split(' ')[1])  # Extract node ID
    node_data_received[node_id] = True

    random_bits = random_data.strip("{}").split("'")[1]  # Extract random bits
    aggregated_results += random_bits

    # Once we have data from all nodes, submit to blockchain
    if all(node_data_received):
        print(f"\n--- Aggregated Results: --- \n{aggregated_results}")
        submit_to_blockchain(node_id, aggregated_results)  # Submit to blockchain

        # Reset for the next round
        aggregated_results = ''
        node_data_received = [False] * (num_nodes + 1)
        print("\n--- Waiting for new data from nodes... ---\n")

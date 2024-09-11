# aggregator.py 
# © 2024 Reece Dixon. All Rights Reserved. 
# 
# Proprietary License: This code is licensed under the Reece Dixon Proprietary License. Unauthorized copying,
# distribution, or modification of this code is strictly prohibited without express written permission from the owner.
#
# Confidentiality Notice: The information contained in this file is confidential and proprietary to Reece Dixon. 
# It is intended solely for the use of the authorized recipient. Any unauthorized use, reproduction, 
# or disclosure of this material is prohibited.

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
    # Replace with your contract address and ABI
    with open("path/to/your/contract_abi.json") as f:
        abi = json.load(f)
    contract = w3.eth.contract(address='YOUR_CONTRACT_ADDRESS', abi=abi)

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

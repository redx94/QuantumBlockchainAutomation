#!/bin/bash

# Step 1: Free necessary ports
echo "Freeing up necessary ports..."
./free_ports.sh

# Step 2: Start Ganache (in the background)
echo "Starting Ganache..."
nohup ganache-cli > ganache.log 2>&1 &

# Step 3: Deploy the smart contract using Truffle
echo "Deploying the smart contract..."
truffle migrate --reset

# Step 4: Extract ABI and save to file
echo "Extracting ABI..."
python extract_abi.py

# Step 5: Start the nodes
echo "Starting Node 1..."
nohup python node1.py > node1.log 2>&1 &
echo "Starting Node 2..."
nohup python node2.py > node2.log 2>&1 &

# Step 6: Start the aggregator
echo "Starting the aggregator..."
nohup python aggregator.py > aggregator.log 2>&1 &

echo "All services started. Check log files for details."

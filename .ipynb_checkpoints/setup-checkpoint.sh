#!/bin/bash
echo "Starting Ganache..."
ganache-cli &  # Run Ganache in the background

echo "Checking for web3.py installation..."
if ! python3 -m pip show web3 > /dev/null 2>&1; then
    echo "Installing web3.py..."
    python3 -m pip install web3
else
    echo "web3.py is already installed."
fi

echo "Checking for Truffle installation..."
if ! command -v truffle > /dev/null; then
    echo "Installing Truffle..."
    npm install -g truffle
else
    echo "Truffle is already installed."
fi

echo "Deploying the smart contract..."
truffle compile
truffle migrate --reset --network development

echo "Smart contract deployed. Starting the nodes..."
# Run the nodes and aggregator (adjust these as needed)
python3 node1.py &
python3 node2.py &
python3 aggregator.py &

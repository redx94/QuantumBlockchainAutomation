
# Quantum Blockchain Automation Script
# © 2024 Reece Dixon. All Rights Reserved.
# Proprietary License: Unauthorized copying, distribution, or modification is prohibited without express written permission.
# Confidentiality Notice: The information contained in this script is confidential and proprietary to Reece Dixon.

# Check for Ganache installation and start it
Write-Host "Starting Ganache blockchain..."
Start-Process "C:\Path\To\Ganache\Ganache.exe"

# Check if web3.py is installed, if not, install it
Write-Host "Checking for web3.py installation..."
$web3Installed = pip show web3

if (!$web3Installed) {
    Write-Host "web3.py not found. Installing..."
    pip install web3
} else {
    Write-Host "web3.py is already installed."
}

# Check for Truffle installation, if not, install it
Write-Host "Checking for Truffle installation..."
$truffleInstalled = Get-Command truffle -ErrorAction SilentlyContinue

if (!$truffleInstalled) {
    Write-Host "Truffle not found. Installing..."
    npm install -g truffle
} else {
    Write-Host "Truffle is already installed."
}

# Set the path for the smart contract
$contractPath = "C:\Path\To\Your\QRNGLedger.sol"

# Compile and deploy the smart contract using Truffle
Write-Host "Deploying the smart contract..."
truffle compile
truffle migrate --reset --network development

# Get the contract address and ABI after deployment
Write-Host "Retrieving contract address and ABI..."
$contractAddress = Get-Content "build/contracts/QRNGLedger.json" | ConvertFrom-Json | Select-Object -ExpandProperty networks | Select-Object -ExpandProperty '5777' | Select-Object -ExpandProperty address
$contractAbi = Get-Content "build/contracts/QRNGLedger.json" | ConvertFrom-Json | Select-Object -ExpandProperty abi

# Replace placeholders in the aggregator.py script
$aggregatorPath = "C:\Path\To\Your\aggregator.py"

# Update contract address
Write-Host "Updating contract address in aggregator.py..."
(Get-Content $aggregatorPath) -replace 'YOUR_CONTRACT_ADDRESS', $contractAddress | Set-Content $aggregatorPath

# Save ABI to a JSON file
Write-Host "Saving ABI to contract_abi.json..."
$abiPath = "C:\Path\To\Your\contract_abi.json"
$contractAbi | ConvertTo-Json | Set-Content $abiPath

# Ensure the aggregator.py script points to the correct ABI file
Write-Host "Updating ABI path in aggregator.py..."
(Get-Content $aggregatorPath) -replace 'path/to/your/contract_abi.json', $abiPath | Set-Content $aggregatorPath

# Start the nodes
Write-Host "Starting Node 1 and Node 2..."
Start-Process "python" "C:\Path\To\Your\node1.py"
Start-Process "python" "C:\Path\To\Your\node2.py"

# Start the aggregator
Write-Host "Starting the aggregator..."
Start-Process "python" $aggregatorPath

Write-Host "Setup complete. Blockchain logging in progress..."

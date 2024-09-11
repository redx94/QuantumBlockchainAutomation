# Quantum Blockchain Automation Setup Script
# © 2024 Reece Dixon. All Rights Reserved.

function Install-Python {
    Write-Host "Python not found. Installing Python..."
    Start-Process -NoNewWindow -Wait "https://www.python.org/ftp/python/3.10.5/python-3.10.5-amd64.exe" "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Write-Host "Python installed."
}

function Install-NodeJS {
    Write-Host "Node.js not found. Installing Node.js..."
    Invoke-WebRequest -Uri "https://nodejs.org/dist/v16.15.1/node-v16.15.1-x64.msi" -OutFile "$env:TEMP\nodejs.msi"
    Start-Process msiexec.exe -ArgumentList "/i $env:TEMP\nodejs.msi /quiet" -Wait
    Write-Host "Node.js installed."
}

function Install-GanacheCLI {
    Write-Host "ganache-cli not found. Installing ganache-cli..."
    npm install -g ganache-cli
    Write-Host "ganache-cli installed."
}

function Install-Truffle {
    Write-Host "Truffle not found. Installing Truffle..."
    npm install -g truffle
    Write-Host "Truffle installed."
}

function Install-web3py {
    Write-Host "web3.py not found. Installing web3.py..."
    pip install web3
    Write-Host "web3.py installed."
}

# Check if Python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Install-Python
} else {
    Write-Host "Python is already installed."
}

# Check if pip is installed
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Host "pip not found. Please install pip manually or check your Python installation."
    exit
} else {
    Write-Host "pip is already installed."
}

# Check if web3.py is installed
if (-not (pip show web3)) {
    Install-web3py
} else {
    Write-Host "web3.py is already installed."
}

# Check if Node.js is installed
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Install-NodeJS
} else {
    Write-Host "Node.js is already installed."
}

# Check if npm is installed
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "npm not found. Please check your Node.js installation."
    exit
} else {
    Write-Host "npm is already installed."
}

# Check if Truffle is installed
if (-not (Get-Command truffle -ErrorAction SilentlyContinue)) {
    Install-Truffle
} else {
    Write-Host "Truffle is already installed."
}

# Check if ganache-cli is installed
if (-not (Get-Command ganache-cli -ErrorAction SilentlyContinue)) {
    Install-GanacheCLI
} else {
    Write-Host "ganache-cli is already installed."
}

# Start Ganache CLI
Write-Host "Starting ganache-cli..."
Start-Process -NoNewWindow -Wait "ganache-cli"

# Deploy the smart contract
Write-Host "Deploying the smart contract..."
truffle compile
truffle migrate --reset --network development

# Assuming the contract is now built, update paths dynamically for contract info
$contractJsonPath = "$PWD\build\contracts\QRNGLedger.json"
if (-not (Test-Path $contractJsonPath)) {
    Write-Host "Smart contract build not found. Please ensure Truffle compiled the contract."
    exit
}

# Update aggregator with contract address and ABI
$aggregatorPath = "$PWD\aggregator.py"
$contractJson = Get-Content $contractJsonPath | ConvertFrom-Json
$contractAddress = $contractJson.networks["5777"].address
$abi = $contractJson.abi | ConvertTo-Json

(Get-Content $aggregatorPath) -replace 'YOUR_CONTRACT_ADDRESS', $contractAddress | Set-Content $aggregatorPath
$abi | Out-File "contract_abi.json"

Write-Host "Setup complete. Starting nodes and aggregator..."
Start-Process -NoNewWindow python3 "$PWD\node1.py"
Start-Process -NoNewWindow python3 "$PWD\node2.py"
Start-Process -NoNewWindow python3 "$PWD\aggregator.py"


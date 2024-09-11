# Quantum Blockchain Automation Script
# © 2024 Reece Dixon. All Rights Reserved.

# Function to check if a program is installed
function Is-Installed($program) {
    Get-Command $program -ErrorAction SilentlyContinue
}

# Function to install a program using chocolatey (for Windows installations)
function Install-Program {
    param(
        [string]$programName,
        [string]$chocoPackageName
    )
    
    if (!(Is-Installed $programName)) {
        Write-Host "$programName is not installed. Installing..."
        
        # Check if chocolatey is installed, if not, install it
        if (!(Is-Installed choco)) {
            Write-Host "Chocolatey is not installed. Installing Chocolatey..."
            Set-ExecutionPolicy Bypass -Scope Process -Force; \
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
            iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        
        choco install $chocoPackageName -y
    } else {
        Write-Host "$programName is already installed."
    }
}

# 1. Check and install Python if needed
Install-Program "python" "python"

# 2. Install pip if it's not found
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Host "pip not found. Installing pip..."
    python -m ensurepip --upgrade
} else {
    Write-Host "pip is already installed."
}

# 3. Install web3.py if needed
if (-not (python -m pip show web3)) {
    Write-Host "Installing web3.py..."
    python -m pip install web3
} else {
    Write-Host "web3.py is already installed."
}

# 4. Check and install Node.js and npm if needed
Install-Program "node" "nodejs-lts"

# 5. Install Truffle if needed
if (!(Is-Installed truffle)) {
    Write-Host "Truffle not found. Installing Truffle..."
    npm install -g truffle
} else {
    Write-Host "Truffle is already installed."
}

# 6. Check and install Ganache CLI if needed
if (!(Is-Installed ganache-cli)) {
    Write-Host "Installing Ganache CLI..."
    npm install -g ganache-cli
} else {
    Write-Host "Ganache CLI is already installed."
}

# Start Ganache CLI
Write-Host "Starting Ganache..."
Start-Process "ganache-cli"

# Deploy smart contracts using Truffle
Write-Host "Deploying the smart contract..."
truffle compile
truffle migrate --reset --network development

# Assuming the contract is now built, update paths dynamically for contract info
$contractJsonPath = "build/contracts/QRNGLedger.json"
if (-not (Test-Path $contractJsonPath)) {
    Write-Host "Smart contract build not found. Please ensure Truffle compiled the contract."
    exit
}

# Update aggregator with contract address and ABI
$aggregatorPath = "C:\Users\reece\Downloads\QuantumBlockchainAutomation\aggregator.py"
$contractJson = Get-Content $contractJsonPath | ConvertFrom-Json
$contractAddress = $contractJson.networks["5777"].address
$abi = $contractJson.abi | ConvertTo-Json

(Get-Content $aggregatorPath) -replace 'YOUR_CONTRACT_ADDRESS', $contractAddress | Set-Content $aggregatorPath
$abi | Out-File "contract_abi.json"

Write-Host "Setup complete. Starting nodes and aggregator..."
Start-Process "python" "node1.py"
Start-Process "python" "node2.py"
Start-Process "python" "aggregator.py"

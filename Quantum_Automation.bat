
@echo off
REM Quantum Blockchain Automation Batch Script
REM © 2024 Reece Dixon. All Rights Reserved.

REM Step 1: Download the repository from GitHub
echo Cloning the GitHub repository...
git clone https://github.com/YOUR_GITHUB_USERNAME/QuantumBlockchainAutomation.git
cd QuantumBlockchainAutomation

REM Step 2: Run the PowerShell script
echo Running the PowerShell script to set up Ganache, deploy the smart contract, and start the nodes and aggregator.
PowerShell -ExecutionPolicy Bypass -File Quantum_Setup.ps1

REM Step 3: Pause to show output
pause

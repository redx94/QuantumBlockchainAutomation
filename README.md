
# QuantumBlockchainAutomation

## Project Overview

Welcome to **QuantumBlockchainAutomation**, the groundbreaking project that merges **Quantum Computing** and **Blockchain Technology** to create a decentralized, quantum-powered data integrity system. This repository houses everything you need to run a **Distributed Quantum Random Number Generator (QRNG)**, which logs results immutably to the blockchain.

This project is designed to demonstrate a **decentralized quantum system** that generates random numbers using quantum computing, aggregates them across multiple nodes, and securely logs them to a blockchain for immutable records.

### Why Quantum and Blockchain?

1. **Quantum Computing**: We leverage quantum circuits to generate truly random numbers using **Qiskit**.
2. **Blockchain**: We use **Ethereum's blockchain (via Ganache)** to record and log data to ensure immutability and trust.
3. **Decentralization**: With **ZeroMQ**, we distribute quantum computation across multiple nodes, allowing for a distributed network that cooperates and processes quantum random data.

This repo automates everything from **smart contract deployment**, to **node setup**, and **blockchain integration**, making it easier to interact with decentralized quantum data.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Components](#components)
- [Setup and Installation](#setup-and-installation)
- [Automation Details](#automation-details)
- [Smart Contracts](#smart-contracts)
- [Quantum Random Number Generation](#quantum-random-number-generation)
- [GitHub Automation & CI/CD](#github-automation--cicd)
- [How to Use](#how-to-use)
- [Project Vision](#project-vision)

---

## Components

### 1. **Quantum Random Number Generation (QRNG)**

- **Qiskit-based QRNG** generates random numbers through quantum circuits (Hadamard gates).
- Each node runs a quantum circuit and contributes random data.

### 2. **ZeroMQ for Distributed Nodes**

- **ZeroMQ** facilitates communication between nodes, allowing data to flow seamlessly between different entities.
  
### 3. **Blockchain Integration with Ethereum (Ganache)**

- **Smart Contracts** (written in Solidity) ensure random data is logged securely and immutably to the blockchain.
  
### 4. **Automation via PowerShell & Batch Scripts**

- **PowerShell** and **Batch Scripts** automate everything from installing dependencies, deploying smart contracts, and running the nodes.

---

## Setup and Installation

### Prerequisites

- **Ganache**: Local Ethereum blockchain for testing.
- **Python**: Used for running quantum simulations and node operations.
- **Node.js** and **Truffle**: For smart contract compilation and deployment.
- **Git**: For cloning the repository.

### Installation Steps

1. Clone this repository:

    ```bash
    git clone https://github.com/redx94/QuantumBlockchainAutomation.git
    cd QuantumBlockchainAutomation
    ```

2. Install dependencies:
    - For Python dependencies:

      ```bash
      pip install -r requirements.txt
      ```

    - For Node.js dependencies:

      ```bash
      npm install
      ```

3. Ensure **Ganache** is installed and running:
    - Launch Ganache, make sure it's running on `http://127.0.0.1:7545`.

4. Deploy Smart Contracts:
    - **Truffle** is used to deploy the contract to Ganache.

    ```bash
    truffle migrate --reset --network development
    ```

5. Run the automation scripts:
    - Use the `.bat` file for automatic deployment:

    ```bash
    Quantum_Automation.bat
    ```

---

## Automation Details

### **PowerShell & Batch Script Automation**

- **Quantum_Setup.ps1**:
  - Handles smart contract deployment, updates the aggregator script with the correct contract address and ABI, and runs the nodes and aggregator.
  - Installs necessary dependencies, including `web3.py` and `Truffle`, if not already present.

- **Quantum_Automation.bat**:
  - Simplifies everything into one command.
  - Clones the repository, runs the PowerShell script, and provides a clean interface for setup.

### **Deployment Steps Handled by Automation:**

1. **Ganache** startup and connection.
2. **Truffle** compilation and smart contract deployment.
3. **Node and Aggregator** startup.
4. **ZeroMQ** communication between nodes.
5. Logging quantum random data to the blockchain.

---

## Smart Contracts

### QRNGLedger.sol

This Solidity contract stores quantum random numbers and their associated node IDs in an immutable ledger.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QRNGLedger {
    struct QRNGEntry {
        uint nodeId;
        string randomResult;
    }
    
    QRNGEntry[] public entries;

    // Add a new quantum random number entry
    function addEntry(uint _nodeId, string memory _randomResult) public {
        QRNGEntry memory newEntry = QRNGEntry({
            nodeId: _nodeId,
            randomResult: _randomResult
        });
        entries.push(newEntry);
    }
}
```

---

## Quantum Random Number Generation

Using **Qiskit**, we generate quantum random numbers via Hadamard gates on qubits. Each node contributes its quantum random numbers to an aggregator, which logs them on the blockchain.

---

## GitHub Automation & CI/CD

We include **GitHub Actions** for automated deployments, ensuring the smart contracts are always up-to-date. You can set up GitHub workflows to automate:

1. **Smart Contract Compilation and Deployment**: Automated upon new contract changes.
2. **Node Testing**: Run simulations to verify node behavior using distributed quantum random number generation.

### Sample GitHub Workflow (.github/workflows/deploy.yml)

```yaml
name: Deploy Smart Contract

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Node.js
      uses: actions/setup-node@v1
      with:
        node-version: '14'

    - name: Install dependencies
      run: npm install

    - name: Compile and Deploy Smart Contract
      run: |
        npm run build
        truffle migrate --reset --network development
```

---

## How to Use

### Running the System

1. Clone the repo, install dependencies, and run the `Quantum_Automation.bat` file.
2. Watch as the script deploys the contract, starts nodes, and logs quantum data to the blockchain.

---

## Project Vision

The **QuantumBlockchainAutomation** project sets the foundation for a **decentralized, quantum-powered future** where data integrity is ensured through the combination of blockchain and quantum randomness. Our goal is to create a system where **quantum-generated randomness** can be leveraged for **security**, **data integrity**, and **scientific simulations**, all while maintaining decentralized control.

We envision this system as the first step toward **quantum data clouds**, where distributed quantum computing resources are used to generate, aggregate, and secure data in ways that weren’t possible before.

Join us on this groundbreaking journey as we explore the intersection of **quantum computing** and **decentralized blockchain technology**!

---

© 2024 Reece Dixon. All Rights Reserved. Unauthorized copying, distribution, or modification is prohibited without express written permission.

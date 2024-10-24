# 🌟 Quantum Blockchain Automation 🌟

## Project Overview

Welcome to **Quantum Blockchain Automation**. This project aims to create a decentralized, quantum-powered data integrity system. The combination of **Quantum Computing** and **Blockchain Technology** provides a unique approach to achieving unprecedented levels of security and reliability. Quantum computing generates truly random numbers, while blockchain ensures that data remains immutable and distributed, offering a powerful solution for data integrity.

This repository holds everything you need to run a **Distributed Quantum Random Number Generator (QRNG)** that immutably logs results to the blockchain.

This project demonstrates a **decentralized quantum system**. First, it generates random numbers using quantum computing. Next, these numbers are aggregated across multiple nodes. Finally, the data is logged securely to a blockchain for immutable records.

### 🤖 Why Quantum and Blockchain?

1. **Quantum Computing**: Leverages quantum circuits to generate truly random numbers using **Qiskit**.
2. **Blockchain**: Uses **Ethereum's blockchain (via Ganache)** to ensure immutability and trust by recording and logging data.
3. **Decentralization**: With **ZeroMQ**, quantum computations are distributed across multiple nodes, enabling a decentralized network for processing quantum data.

The repository automates everything from **smart contract deployment** to **node setup** and **blockchain integration**. For example, the automation scripts handle the entire process, from deploying blockchain contracts via Truffle, configuring node communication with ZeroMQ, to managing secure logging of quantum random numbers.

---

## 📜 Table of Contents

- [Project Overview](#project-overview)
- [Components](#components)
- [Setup and Installation](#setup-and-installation)
- [Automation Details](#automation-details)
- [Interactive Dashboard](#interactive-dashboard)
- [Live Quantum Integration](#live-quantum-integration)
- [How to Use](#how-to-use)
- [Project Vision](#project-vision)

---

## ⚙️ Components

### 1. **Quantum Random Number Generation (QRNG)** 🔑

- **Qiskit-based QRNG**: Generates random numbers using quantum circuits with Hadamard gates.
- Each node runs a quantum circuit and contributes random data.

### 2. **ZeroMQ for Distributed Nodes** 🌐

- **ZeroMQ**: Facilitates seamless communication between nodes, allowing data to flow across different entities.

### 3. **Blockchain Integration with Ethereum (Ganache)** ⛓️

- **Smart Contracts** (written in Solidity): Ensure that random data is logged securely and immutably to the blockchain.

### 4. **Automation via PowerShell & Batch Scripts** 🤖

- **PowerShell** and **Batch Scripts**: Automate tasks including dependency installation, smart contract deployment, and node operations.

### 5. **Interactive Dashboard** 📊

- A **web-based dashboard** visualizes real-time quantum randomness and blockchain transactions. Built using **Flask** for backend API integration and **Chart.js** for visualization.

---

## ⚡ Setup and Installation

### Prerequisites

- **Ganache**: Local Ethereum blockchain for testing.
- **Python**: Used for running quantum simulations and node operations.
- **Node.js** and **Truffle**: For smart contract compilation and deployment.
- **Git**: For cloning the repository.

### Installation Steps

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/redx94/QuantumBlockchainAutomation.git
    cd QuantumBlockchainAutomation
    ```

2. **Install Dependencies**:
    - For Python dependencies:

      ```bash
      pip install -r requirements.txt
      ```

    - For Node.js dependencies:

      ```bash
      npm install
      ```

3. **Ensure Ganache is Running**:
    - Launch **Ganache** and make sure it's available at `http://127.0.0.1:7545`.

4. **Deploy Smart Contracts**:
    - Use **Truffle** to deploy contracts to Ganache.

    ```bash
    truffle migrate --reset --network development
    ```

5. **Run Automation Scripts**:
    - Use the `.bat` file for automatic deployment:

    ```bash
    Quantum_Automation.bat
    ```

6. **Start the Interactive Dashboard**:
    - Run the **Flask** server to serve the dashboard.
    ```bash
    python dashboard.py
    ```
    - Open your browser and navigate to `http://127.0.0.1:5000` to view the dashboard.

    - Ensure **Chart.js** is included in the HTML file to correctly display the data visualization.

    ```html
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    ```

---

## 🤖 Automation Details

### **PowerShell & Batch Script Automation** 🛠️

- **Quantum_Setup.ps1**:
  - Handles smart contract deployment, updates the aggregator script with the correct contract address and ABI, and runs nodes and aggregator. The aggregator script gathers quantum random numbers from different nodes and compiles them for secure logging on the blockchain, ensuring that all data points are accurately recorded.
  - Installs necessary dependencies, including `web3.py` and `Truffle`, if not already present.

- **Quantum_Automation.bat**:
  - Simplifies the setup into a single command.
  - Clones the repository, runs the PowerShell script, and provides a seamless interface for setup.

### **Deployment Steps Handled by Automation:**

1. **Ganache** startup and connection.
2. **Truffle** compilation and smart contract deployment.
3. **Node and Aggregator** startup.
4. **ZeroMQ** communication between nodes.
5. **Blockchain Logging** of quantum random data.

---

## 📊 Interactive Dashboard

The project includes an **interactive web dashboard** to provide visualization for real-time quantum randomness and blockchain transactions.

### Key Features:
- **Live Randomness Tracking**: Real-time tracking of the quantum-generated random numbers.
- **Blockchain Status**: A table showcasing recent blockchain transactions involving quantum random numbers.

### Steps to Set Up the Dashboard:
1. **Run the Flask API Server** (`dashboard.py`) to enable data access for the dashboard.
2. **Frontend** (in `dashboard/index.html`) visualizes the random data using **Chart.js**.

    - **Note**: Ensure you have Flask installed to run the server.
    ```bash
    pip install Flask
    ```

    - The frontend polls the Flask server every few seconds to update the charts.

    ```javascript
    async function fetchNodeData() {
        const response = await fetch('/api/nodes');
        const data = await response.json();
        return data.nodes.map(node => parseInt(node.last_random_number, 2));
    }
    ```

---

## ⚛️ Live Quantum Integration

This project allows you to switch from a local quantum simulator to a **real quantum device**.

### Steps for IBM Q Integration:
1. **Sign up** for IBM Quantum Experience and get an **API key**.
2. Add your credentials to `config/ibm_credentials.json`.

    ```json
    {
        "api_key": "YOUR_IBM_API_KEY"
    }
    ```

3. Modify `qrng_module.py` to use IBM's live backend.

    ```python
    from qiskit import IBMQ
    IBMQ.load_account()  # Replace this line with your actual IBM Quantum Experience token
    provider = IBMQ.get_provider(hub='ibm-q')
    simulator = provider.get_backend('ibmq_qasm_simulator')
    ```

4. Update `requirements.txt` to include `qiskit-ibmq-provider`:

    ```
    qiskit
    qiskit-ibmq-provider
    ```

This upgrade allows quantum randomness generated by real quantum hardware to be used in blockchain transactions, increasing unpredictability and security.

---

## 🚀 How to Use

### Running the System

1. **Clone the Repository**, **Install Dependencies**, and run the `Quantum_Automation.bat` file.
2. **Start the Flask Server** to enable the interactive dashboard.
3. **Access the Dashboard** in your browser to visualize the operations.
4. Watch as the script deploys the contract, starts nodes, and logs quantum data to the blockchain.

---

## 🌌 Project Vision

The **Quantum Blockchain Automation** project sets the foundation for a **decentralized, quantum-powered future** where data integrity is ensured through the combination of blockchain and quantum randomness. Our goal is to create a system where **quantum-generated randomness** can be leveraged for **security**, **data integrity**, and **scientific simulations**, all while maintaining decentralized control.

We envision this system as the first step toward **quantum data clouds**, where distributed quantum computing resources are used to generate, aggregate, and secure data in ways that weren’t possible before.

### 💡 Open the Door to New Possibilities!

Imagine a world where **quantum-level randomness** secures everything from **financial systems** and **decentralized games** to **voting systems**. For instance, picture a blockchain-based voting system where quantum-generated randomness ensures voter anonymity and prevents tampering, or a financial application where quantum-level security protects transactions from any cyber threats. These are just a few examples of how quantum technology could revolutionize our daily lives.

We invite developers to **fork** this project, **experiment**, and **contribute** to making a quantum-secured future a reality!! 🚀✨

---

© 2024 Reece Dixon. All Rights Reserved.


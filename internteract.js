async function getQuantumResult(contractAddress) {
    const contract = new ethers.Contract(contractAddress, contractABI, provider);
    const result = await contract.getQuantumResult();
    console.log(`Quantum Result stored on-chain: ${result}`);
}

getQuantumResult('YOUR_CONTRACT_ADDRESS');

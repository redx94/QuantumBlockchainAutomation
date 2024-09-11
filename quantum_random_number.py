from qiskit import QuantumCircuit, Aer, execute

def quantum_random_number():
    # Create a simple quantum circuit with 1 qubit
    qc = QuantumCircuit(1, 1)
    qc.h(0)  # Apply Hadamard gate to create superposition
    qc.measure(0, 0)  # Measure the result

    # Use Qiskit's Aer simulator
    simulator = Aer.get_backend('qasm_simulator')
    job = execute(qc, simulator, shots=1)
    result = job.result()
    counts = result.get_counts(qc)

    # Return the outcome (0 or 1)
    return int(list(counts.keys())[0])

quantum_result = quantum_random_number()
print(f"Quantum Random Number: {quantum_result}")

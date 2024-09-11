# qrng_module.py
from qiskit import QuantumCircuit, Aer, transpile, assemble

def generate_qrng(num_qubits=1):
    """Generates random numbers using a quantum circuit."""
    qc = QuantumCircuit(num_qubits, num_qubits)
    qc.h(range(num_qubits))  # Apply Hadamard gate
    qc.measure(range(num_qubits), range(num_qubits))  # Measure qubits

    simulator = Aer.get_backend('qasm_simulator')
    compiled_circuit = transpile(qc, simulator)
    job = assemble(compiled_circuit, shots=1)  # We only need 1 shot for a single random number
    result = simulator.run(job).result()
    counts = result.get_counts(qc)

    return list(counts.keys())[0]  # Return the random bit string

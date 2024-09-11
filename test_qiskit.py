from qiskit import Aer, execute, QuantumCircuit
simulator = Aer.get_backend('qasm_simulator')
circuit = QuantumCircuit(1, 1)
circuit.h(0)
circuit.measure(0, 0)
job = execute(circuit, simulator, shots=1000)
result = job.result()
counts = result.get_counts(circuit)
print(counts)

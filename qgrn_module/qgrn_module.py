from qiskit import IBMQ, Aer, execute
from qiskit.circuit.random import random_circuit

# Load IBM Q account
IBMQ.load_account()
provider = IBMQ.get_provider(hub='ibm-q')
backend = provider.get_backend('ibmq_qasm_simulator')

# Generate a random quantum circuit and run it
circuit = random_circuit(num_qubits=5, depth=4, measure=True)
job = execute(circuit, backend)
result = job.result()

print(result.get_counts())

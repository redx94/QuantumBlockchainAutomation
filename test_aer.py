from qiskit import Aer

try:
    print(Aer.backends())
except ImportError as e:
    print("Error importing Aer:", e)

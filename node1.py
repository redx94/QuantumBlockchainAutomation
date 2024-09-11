# node1.py (and similar for node2.py)
# Quantum Random Number Generation Node
import zmq
import time
import random
from qrng_module import generate_qrng  # Assuming qrng_module.py contains the QRNG logic

def main():
    context = zmq.Context()
    socket = context.socket(zmq.PUB)
    socket.bind("tcp://*:5555")

    node_id = random.randint(1, 100)

    while True:
        random_numbers = generate_qrng(num_qubits=1)  # Call the quantum RNG function
        message = f"Node {node_id}: {random_numbers}"
        print(f"Sending: {message}")
        socket.send_string(message)
        time.sleep(2)

if __name__ == "__main__":
    main()

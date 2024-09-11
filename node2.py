# node2.py
# Quantum Random Number Generation Node 2
import zmq
import time
import random
from qrng_module import generate_qrng  # Assuming qrng_module.py contains the QRNG logic

def main():
    context = zmq.Context()
    socket = context.socket(zmq.PUB)
    socket.bind("tcp://*:5556")  # You can use a different port if needed

    node_id = random.randint(101, 200)  # Use a different range for Node 2's ID

    while True:
        random_numbers = generate_qrng(num_qubits=1)  # Call the quantum RNG function
        message = f"Node {node_id}: {random_numbers}"
        print(f"Sending: {message}")
        socket.send_string(message)
        time.sleep(2)

if __name__ == "__main__":
    main()

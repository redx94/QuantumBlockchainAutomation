from flask import Flask, jsonify
import random

app = Flask(__name__)

# Sample data for the quantum nodes (simulated data for demo purposes)
nodes_data = {
    'nodes': [
        {'node_id': 1, 'last_random_number': bin(random.randint(0, 1024))},
        {'node_id': 2, 'last_random_number': bin(random.randint(0, 1024))},
        {'node_id': 3, 'last_random_number': bin(random.randint(0, 1024))}
    ]
}

@app.route('/api/nodes', methods=['GET'])
def get_nodes():
    return jsonify(nodes_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

import json

def extract_abi(contract_json_path, output_abi_path):
    # Load the contract's JSON file
    with open(contract_json_path, 'r') as f:
        contract_data = json.load(f)
    
    # Extract the ABI
    abi = contract_data.get('abi', [])
    
    # Save the ABI to a new file
    with open(output_abi_path, 'w') as f:
        json.dump({"abi": abi}, f, indent=2)
    
    print(f"ABI successfully extracted and saved to {output_abi_path}")

if __name__ == "__main__":
    # Set paths to contract build file and output ABI file
    contract_json_path = './build/contracts/QRNGLedger.json'
    output_abi_path = './contract_abi.json'

    # Extract the ABI and save to a file
    extract_abi(contract_json_path, output_abi_path)

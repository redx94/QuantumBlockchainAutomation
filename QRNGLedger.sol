
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QRNGLedger {
    struct QRNGEntry {
        uint nodeId;
        string randomResult;
    }
    
    QRNGEntry[] public entries;

    // Function to add a new entry of random data
    function addEntry(uint _nodeId, string memory _randomResult) public {
        QRNGEntry memory newEntry = QRNGEntry({
            nodeId: _nodeId,
            randomResult: _randomResult
        });
        entries.push(newEntry);
    }

    // Helper function to retrieve all entries (optional)
    function getEntries() public view returns (QRNGEntry[] memory) {
        return entries;
    }
}

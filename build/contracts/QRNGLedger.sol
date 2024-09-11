
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QRNGLedger {
    struct QRNGEntry {
        uint nodeId;
        string randomResult;
    }
    
    QRNGEntry[] public entries;

    // Add a new quantum random number entry
    function addEntry(uint _nodeId, string memory _randomResult) public {
        QRNGEntry memory newEntry = QRNGEntry({
            nodeId: _nodeId,
            randomResult: _randomResult
        });
        entries.push(newEntry);
    }

    // Optional: Retrieve all entries
    function getEntries() public view returns (QRNGEntry[] memory) {
        return entries;
    }
}

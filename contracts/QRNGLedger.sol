// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QRNGLedger {
    struct QRNGEntry {
        uint nodeId;
        string randomResult;
    }

    QRNGEntry[] public entries;

    function addEntry(uint _nodeId, string memory _randomResult) public {
        entries.push(QRNGEntry({
            nodeId: _nodeId,
            randomResult: _randomResult
        }));
    }

    function getEntries() public view returns (QRNGEntry[] memory) {
        return entries;
    }
}

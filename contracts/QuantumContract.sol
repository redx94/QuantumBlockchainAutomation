// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuantumContract {
    uint256 public quantumResult;

    constructor(uint256 _quantumResult) {
        quantumResult = _quantumResult;
    }

    function getQuantumResult() public view returns (uint256) {
        return quantumResult;
    }
}

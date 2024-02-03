// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStore {
    uint256 private value; // storage slot 0

    function store(uint256 newValue) public {
        value = newValue; // stores in storage slot 0
    }

    function read() public view returns (uint256) {
        return value; // reads from storage slot 0
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IDemocracy {
    function transferFrom(address from, address to, uint256 tokenId) external;
}

contract DemocracyHelper {
    IDemocracy democracyContract;

    constructor(address _democracyContract) {
        democracyContract = IDemocracy(_democracyContract);
    }

    function transferToken(address from, address to, uint256 tokenId) public {
        democracyContract.transferFrom(from, to, tokenId);
    }
}

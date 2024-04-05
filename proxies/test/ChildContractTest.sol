// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/ParentContract.sol";
import "../src/ChildContract.sol";
import "forge-std/test.sol";

contract ChildContractTest is Test {


    function setUp() public {
        // Deploy a new ParentContract
        parentContract = new ParentContract();
        // Deploy a new ChildContract
        childContract = new ChildContract();

    }



}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/test.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne public gatekeeper;

    function setUp() public {
        gatekeeper = new GatekeeperOne();
    }

    function testEnterGate() public {
        // gateOne : make sure call is from a contract
        // gateTwo : make sure gasleft() is a multiple of 8191
        // gateThree : make sure the last 2 bytes of the gateKey are equal to the first 2 bytes of the tx.origin address
    }
}

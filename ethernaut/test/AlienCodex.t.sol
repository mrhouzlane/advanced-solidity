// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/test.sol";
import {AlienCodex} from "../src/AlienCodex.sol";

contract AlienCodexTest is Test {
    AlienCodex public alienCodex;

    function setUp() public {
        alienCodex = new AlienCodex();
    }

    function testUnderflow() public {
        alienCodex.make_contact();
        alienCodex.retract();
       
    }
}

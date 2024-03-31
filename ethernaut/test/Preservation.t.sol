// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/test.sol";
import "../src/Preservation.sol";
import "../src/PreservationAttacker.sol";

contract PreservationTest is Test {

    PreservationAttacker public attacker;
    Preservation public preservation;


    function setUp() public {
        attacker = new PreservationAttacker(address(preservation));
    }


    function testTakeOver() public {
        attacker.attack();
        preservation.timeZone1Library();
    }
}

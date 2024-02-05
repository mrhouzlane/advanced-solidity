// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {TrusterLenderPool} from "../src/TrusterLenderPool.sol";
import {TrusterAttacker} from "../src/TrusterAttacker.sol";
import "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract TrusterLenderPoolTest is Test {
    TrusterLenderPool public trusterLenderPool;
    TrusterAttacker public trusterAttacker;
    ERC20Mock public erc20Mock;

    address owner = vm.addr(1);
    address attacker = vm.addr(2);

    function setUp() public {
        vm.startPrank(owner);
        erc20Mock = new ERC20Mock();
        // Add liquidity to the pool
        trusterLenderPool = new TrusterLenderPool(address(erc20Mock));
        // Fund the trusterLenderPool with 1000 tokens
        erc20Mock.mint(address(trusterLenderPool), 1000);
        assertEq(erc20Mock.balanceOf(address(trusterLenderPool)), 1000);
        // Deploy Attacker contract
        vm.prank(attacker);
        trusterAttacker = new TrusterAttacker(address(trusterLenderPool));
    }

    function testFlashLoan() public {
        assertEq(erc20Mock.balanceOf(address(trusterLenderPool)), 1000);
        vm.prank(attacker);
        console.log(erc20Mock.balanceOf(address(attacker)));
        trusterAttacker.executeFlashLoan();
        assertEq(erc20Mock.balanceOf(address(trusterLenderPool)), 0);
        console.log(erc20Mock.balanceOf(address(attacker)));
    }
}

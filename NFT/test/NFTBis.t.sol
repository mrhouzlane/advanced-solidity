// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {NFTBis} from "../src/NFTBis.sol";
// NFT collection with 20 items using ERC721Enumerable. The token ids should be [1..100] inclusive.

contract NFTBisTest is Test {
    NFTBis public nft;

    function setUp() public {
        nft = new NFTBis();
    }

    function testPrime() public {
        assertFalse(nft.isPrime(1));
        assertTrue(nft.isPrime(2));
        assertTrue(nft.isPrime(3));
        assertFalse(nft.isPrime(4));
    }

}

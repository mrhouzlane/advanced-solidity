// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// NFT collection with 20 items using ERC721Enumerable. The token ids should be [1..100] inclusive.
contract NFTCollection is ERC721Enumerable {
    uint256 supply;

    constructor() ERC721("NFTCollection", "NFTC") {}

    // 1. It should have tokens going from id 1 to 100.
    // 2. It should mint 20 tokens to the contract creator.

    modifier rangeTokenIds(uint256 tokenId) {
        require(tokenId >= 1 && tokenId <= 100, "NFTCollection: tokenId out of range");
        _;
    }

    function mint() public {
        require(supply < 20, "NFTCollection: max supply reached");
        supply++;
        _safeMint(msg.sender, supply);
    }
}

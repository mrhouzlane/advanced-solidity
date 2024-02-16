// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// NFT collection with 20 items using ERC721Enumerable. The token ids should be [1..100] inclusive.
contract NFTBis is ERC721Enumerable {
    constructor() ERC721("NFTBis", "NFTBis") {}

    function isPrime(uint256 _num) public pure returns (bool) {
        if (_num <= 1) {
            return false;
        }
        for (uint256 i = 2; i * i <= _num; i++) {
            if (_num % i == 0) {
                return false;
            }
        }
        return true;
    }

    function countPrimeTokens(address _address) external view returns (uint256) {
        uint256 balance = balanceOf(_address);
        uint256 count = 0;

        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(_address, i);
            if (isPrime(tokenId)) {
                count++;
            }
        }

        return count;
    }
}

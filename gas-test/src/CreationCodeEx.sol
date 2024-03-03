// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract CreationCodeEx {
    address public borrower;

    constructor(address _borrower) payable {
        borrower = _borrower;
    }

}

contract Ex {

    function get() external returns (bytes memory creationCode) {
        creationCode = type(CreationCodeEx).creationCode;
    }

}


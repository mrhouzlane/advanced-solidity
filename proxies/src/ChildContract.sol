// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ParentContract.sol";

/**
 * @title Child Contract
 * @dev
 * @author Mehdi
 */
contract ChildContract is ParentContract {
    string public text;
    uint256[50] private __gap;

    function initialize(uint256 _number, string memory _text) public initializer {
        ParentContract.initialize(_number);
        text = _text;
    }
}

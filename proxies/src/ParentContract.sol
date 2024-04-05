// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title Parent Contract upgradeable
 * @dev
 * @author Mehdi
 */
contract ParentContract is Initializable {
    uint256 public number;
    uint256[50] private __gap;

    function initialize(uint256 _number) public initializer {
        number = _number;
    }
}

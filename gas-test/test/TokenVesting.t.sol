// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/TokenVesting.sol";

contract TokenVestingTest is Test {

    TokenVesting public vesting;

    address _owner = address(0x1);
    address _beneficiary = address(0x2);
    uint48  _start = 20;
    uint48 _cliffDuration = 100;
    uint48 _duration = 250;
    bool _revocable = true;


    // function setUp() public {
    //     vesting = new TokenVesting();
    // }


    function testTokenVestingDeploymentGasCost() public {

        uint256 gasCost = gasleft();
        emit log_named_uint("gasCost", gasCost);
        vesting = new TokenVesting(
            _owner,
            _beneficiary,
            _start,
            _cliffDuration,
            _duration,
            _revocable
        );
        gasCost = gasCost - gasleft();
        emit log_named_uint("TokenVesting Deployment Gas Cost", gasCost);
        
    }
   
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RetirementFund.sol";

contract RetirementFundTest is Test {
    RetirementFund public retirementFund;
    ExploitContract public exploitContract;

    address mehdi = makeAddr("mehdi");

    function setUp() public {
        // Deploy contracts
        vm.deal(mehdi, 101 ether);
        vm.startPrank(mehdi);
        retirementFund = (new RetirementFund){value: 1 ether}(address(this));
        exploitContract = new ExploitContract(retirementFund);
        vm.stopPrank();
    }

    function testWithdrawPenaltyWithPenalty() public {
        vm.prank(mehdi);
        retirementFund.withdraw();
        assertEq(mehdi.balance, 100.9 ether);
    }

    function testIncrement() public {
        vm.deal(address(exploitContract), 1 ether);
        
        exploitContract.exploit{value: 1}();
        retirementFund.collectPenalty();

        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(retirementFund.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}

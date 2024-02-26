// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/test.sol";
import {Denial} from "../src/Denial.sol";
import {DenialAttacker} from "../src/DenialAttacker.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DenialTest is Test {
    Denial public denial;
    DenialAttacker public denialAttack;

    address public sender = makeAddr("sender");
    address public partner = makeAddr("partner");

    function setUp() public {
        denial = new Denial();
        denialAttack = new DenialAttacker(address(denial));
        vm.deal(address(denial), 100 ether);
    }

    function testRecipientBalances() public {
        assertEq(denial.contractBalance(), 100 ether);
        denial.setWithdrawPartner(partner);
        vm.prank(sender);
        denial.withdraw();
        assertEq(denial.contractBalance(), 98 ether);
        assertEq(partner.balance, 1 ether);
        assertEq(denial.owner().balance, 1 ether);
    }

    function testFail_OwnerWithdraw() public {
        denialAttack.attack();
        vm.expectRevert("CALL_FAILED_CONSUMED_ALL_GAS");
        denial.withdraw();
    }
}

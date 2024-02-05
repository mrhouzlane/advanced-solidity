// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/test.sol";
import {ReceiverUnstoppable} from "../src/unstoppable/ReceiverUnstoppable.sol";
import {UnstoppableVault} from "../src/unstoppable/UnstoppableVault.sol";
import {MockERC20} from "solmate/src/test/utils/mocks/MockERC20.sol";

contract UnstoppableTest is Test {
    ReceiverUnstoppable receiver;
    UnstoppableVault pool;
    MockERC20 mockToken;
    

    address owner = makeAddr("owner");
    address feeRecipient = makeAddr("feeRecipient");

    function setUp() public {
        // Deploy ERC20Mock
        mockToken = new MockERC20("mockToken", "MTK", 18);
        pool = new UnstoppableVault(mockToken, owner, feeRecipient);
        // Deploy receiver of flashLoan (borrower)
        receiver = new ReceiverUnstoppable(address(pool));
    }

    function test_executeFlashLoan() public {
        receiver.executeFlashLoan(100);
    }
}

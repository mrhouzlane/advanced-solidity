// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {FlashLoanReceiver} from "../src/naive-receiver/FlashLoanReceiver.sol";
import {NaiveReceiverLenderPool} from "../src/naive-receiver/NaiveReceiverLenderPool.sol";
import "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract NaiveReceiverTest is Test {}

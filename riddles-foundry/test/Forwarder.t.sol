// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {Wallet, Forwarder} from "../src/Forwarder.sol";

contract ForwarderTest is Test {
    Wallet public wallet;
    Forwarder public forwarderContract;


    function setUp() public {
        forwarderContract = new Forwarder();
        vm.prank(address(forwarderContract));
        vm.deal(address(forwarderContract), 10 ether);
        wallet = new Wallet{value: 1 ether}(address(forwarderContract));
    }

    function testSendEtherOnlyByForwarder() public {
        vm.startPrank(address(forwarderContract));
        bytes memory data = abi.encodeWithSignature("sendEther(address,uint256)", address(this), 1 ether);
        forwarderContract.functionCall(address(wallet), data);
        vm.stopPrank();
    }

    receive() external payable {}

}

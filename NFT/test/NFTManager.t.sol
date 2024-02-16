// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {NFTSpecial} from "../src/NFTSpecial.sol";
import {NFTManager} from "../src/NFTManager.sol";
import {RewardToken} from "../src/RewardToken.sol";
import "forge-std/console.sol";

contract NFTManagerTest is Test {
    NFTSpecial public nftspecial;
    NFTManager public nftManager;
    RewardToken public rewardToken;

    address owner = vm.addr(1);
    address artist = vm.addr(2);
    address Alice;

    function setUp() public {
        Alice = makeAddr("Alice");
        nftspecial = new NFTSpecial(owner, bytes32(0), artist);
        rewardToken = new RewardToken(20000);
        nftManager = new NFTManager(owner, address(rewardToken));
        console2.log("NFTManager address: %s", address(nftManager));
        dealToAddress();
    }

    function testUnstake() public {
        address Bob = vm.addr(0x2);
        vm.startPrank(Bob);
        vm.deal(Bob, 1 ether);
        nftspecial.mint{value: 1 ether}();
        console.log("BalanceBefore");
        console.log(nftspecial.balanceOf(Bob));
        nftspecial.transferNFT(address(nftManager));
        console.log("BalanceAfter");
        console.log(nftspecial.balanceOf(Bob));
    }

    function dealToAddress() internal {
        vm.deal(owner, 100 ether);
        vm.deal(Alice, 100 ether);
    }
}

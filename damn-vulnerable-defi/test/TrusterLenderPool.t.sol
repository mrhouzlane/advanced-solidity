// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {TrusterLenderPool} from "../src/TrusterLenderPool.sol";
import "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract TrusterLenderPoolTest is Test {
    TrusterLenderPool public trusterLenderPool;
    ERC20Mock public erc20Mock;

    address owner = vm.addr(1);

    function setUp() public {
        erc20Mock = new ERC20Mock();
        trusterLenderPool = new TrusterLenderPool(address(erc20Mock));
    }


}

pragma solidity 0.8.15;

import "forge-std/test.sol";
import "../src/DeleteUser.sol";

contract ReadOnlyTest is Test {
    ReadOnlyPool public readOnlyPool;

    function setUp() public {
        readOnlyPool = new ReadOnlyPool();
    }

    function testAddLiquidity() public {
        uint initialBalance = address(this).balance;
        
    }
}

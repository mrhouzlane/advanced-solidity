// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/CreationCodeEx.sol";

contract CreationCodeExTest is Test {
    CreationCodeEx public cc;
    address public borrower = makeAddr("borrower");

    function setUp() public {
        cc = new CreationCodeEx(borrower);
        Ex ex = new Ex();
    }

    function testBorrowerIsSet() public {
        assertEq(address(cc.borrower()), borrower);
    }

    function testGetCreationCode() public {
        Ex ex = new Ex();
        bytes memory creationCode = ex.get();
        CreationCodeEx cc2 = new CreationCodeEx(borrower);
        assertEq(creationCode, type(CreationCodeEx).creationCode);
    }
}

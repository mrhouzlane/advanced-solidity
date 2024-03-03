// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StringStorage1 {
    // Uses only one slot
    // slot 0: 0x(len * 2)00...hex of (len * 2)(hex"hello")
    // Has smaller gas cost due to size.
    string public exampleString = "hello rareskills";
    // 16
    // 16*2
    //

    function getString() public view returns (string memory) {
        return exampleString;
    }
}

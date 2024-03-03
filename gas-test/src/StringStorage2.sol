// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StringStorage2 {
    // Length is more than 32 bytes.
    // Slot 0: 0x00...(length*2+1).
    // keccak256(0x00): stores hex representation of "hello"
    // Has increased gas cost due to size.
    string public exampleString = "This is a string that is slightly over 32 bytes!";

    function getStringLongerThan32bytes() public view returns (string memory) {
        return exampleString;
    }
}

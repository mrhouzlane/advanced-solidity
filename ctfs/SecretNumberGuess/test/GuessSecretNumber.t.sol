// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/GuessSecretNumber.sol";

contract GuessSecretNumberTest is Test {
    ExploitContract exploitContract;
    GuessTheSecretNumber guessTheSecretNumber;

    function setUp() public {
        guessTheSecretNumber = (new GuessTheSecretNumber){value: 1 ether}();
        exploitContract = new ExploitContract();
    }

    function testFindSecretNumber() public {
        uint8 secretNumber = exploitContract.Exploiter();
        _checkSolved(secretNumber);
    }

    function _checkSolved(uint8 _secretNumber) internal {
        assertTrue(
            guessTheSecretNumber.guess{value: 1 ether}(_secretNumber),
            "Wrong Number"
        );
        assertTrue(guessTheSecretNumber.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}

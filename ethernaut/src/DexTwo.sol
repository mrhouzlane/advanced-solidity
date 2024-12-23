// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DexTwo {
    address public token1;
    address public token2;

    constructor(address _token1, address _token2) public {
        token1 = _token1;
        token2 = _token2;
    }

    function swap(address from, address to, uint256 amount) public {
        //@audit - This function is missing checks for the token addresses (we can swap any tokens)
        require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
        uint256 swap_amount = get_swap_amount(from, to, amount);
        IERC20(from).transferFrom(msg.sender, address(this), amount);
        IERC20(to).approve(address(this), swap_amount);
        IERC20(to).transferFrom(address(this), msg.sender, swap_amount);
    }

    function add_liquidity(address token_address, uint256 amount) public {
        IERC20(token_address).transferFrom(msg.sender, address(this), amount);
    }

    function get_swap_amount(address from, address to, uint256 amount) public view returns (uint256) {
        return ((amount * IERC20(to).balanceOf(address(this))) / IERC20(from).balanceOf(address(this)));
    }

    function approve(address spender, uint256 amount) public {
        SwappableTokenTwo(token1).approve(spender, amount);
        SwappableTokenTwo(token2).approve(spender, amount);
    }

    function balanceOf(address token, address account) public view returns (uint256) {
        return IERC20(token).balanceOf(account);
    }
}

contract SwappableTokenTwo is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply) public ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
}

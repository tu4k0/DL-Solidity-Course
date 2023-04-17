// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IVault {
    function deposit() external payable;

    function withdrawSafe(address payable holder) external;

    function withdrawUnsafe(address payable holder) external;
}

contract Vault is IVault {
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawSafe(address payable holder) external {
        uint256 amount = balance[holder];
        require(amount > 0, "Holder have no funds");
        balance[holder] = 0;
        (bool success, ) = holder.call{value: amount}("");
        require(success, "Safe transfer fail");
    }

    function withdrawUnsafe(address payable holder) external {
        uint256 amount = balance[holder];
        require(amount > 0, "Holder have no funds");
        (bool success, ) = holder.call{value: amount}("");
        require(success, "Unsafe transfer fail");
        balance[holder] = 0;
    }
}
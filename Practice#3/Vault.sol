// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "Task3.sol";

contract Vault is IVault {
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawSafe(address payable holder) external {
        (bool success, ) = holder.call{value: balance[msg.sender]}("");
        require(success, "Safe Transfer Fail");
        delete balance[holder];
    }

    function withdrawUnsafe(address payable holder) external {
        (bool success, ) = holder.call{value: address(this).balance}("");
        require(success, "Unsafe Transfer Fail");
        delete balance[holder];
    }
}

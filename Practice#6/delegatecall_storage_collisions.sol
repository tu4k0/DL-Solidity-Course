// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

abstract contract ArrayStorage {
    uint256[] private array;

    function collide() external virtual;

    function getArray() external view returns (uint256[] memory) {
        return array;
    }
}

contract StorageCollider is ArrayStorage {
    address public addr;

    constructor (address _addr) {
        addr = _addr;
    }

    function collide() external override {
       (bool success, ) = addr.delegatecall(abi.encodeWithSelector(ArrayFiller.fillarray.selector));
       require(success, "Fail to fill array (delegatecall error)");
    }
}

contract ArrayFiller {
    uint256[] private array;

    function fillarray() external {
        for(uint256 i = 1; i < 15; i++) {
            array.push(i);
        }
    }
}
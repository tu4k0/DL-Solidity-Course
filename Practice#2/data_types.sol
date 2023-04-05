// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "Task2.sol";

contract DataTypes is IDataTypesPractice{
   int256 public temperature;
   uint256 public year;
   int8 public percent;
   uint8 public month;
   bool public isDone;
   address public wallet;
   bytes32 public date;
   uint256[5] public accounts;
   uint256[] public keys = new uint256[](2);
   string public greet;

   constructor() {
        temperature = -100;
        year = 2023;
        percent = -55;
        month = 12;
        isDone = true;
        wallet = 0xe7FAF394998dFeEB8CC7da36404551878428E856;
        date = hex"04042023";
        accounts = [1, 2, 3, 4, 5];
        keys = [1, 2];
        greet = "Hello World!";
   }

    function getInt256() external view returns (int256){
        return temperature;
    }

    function getUint256() external view returns (uint256){
        return year;
    }

    function getInt8() external view returns (int8){
        return percent;
    }

    function getUint8() external view returns (uint8){
        return month;
    }

    function getBool() external view returns (bool){
        return isDone;
    }

    function getAddress() external view returns (address){
        return wallet;
    }

    function getBytes32() external view returns (bytes32){
        return date;
    }

    function getArrayUint5() external view returns (uint256[5] memory){
        return accounts;
    }

    function getArrayUint() external view returns (uint256[] memory){
        return keys;
    }

    function getString() external view returns (string memory){
        return greet;
    }

    function getBigUint() external pure returns (uint256){
        uint256 v1 = 1;
        uint256 v2 = 2;

        return (++v2)**((v2+v2)*(v1<<v2));
    }
}
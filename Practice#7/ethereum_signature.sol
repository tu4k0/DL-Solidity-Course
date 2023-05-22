// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

abstract contract AuthorizedValue {
    uint256 private value;

    address private messageOwner = 0x5A902DB2775515E98ff5127EFEa53D1CC9EE1912;

    function setValueRaw(
        uint256 value_,
        bytes32 messageHash,
        bytes32 r,
        bytes32 s,
        uint8 v
    ) public {
        address signer = ecrecover(messageHash, v, r, s);

        require(signer == messageOwner, "Invalid signature.");

        value = value_;
    }

    function setValue(uint256 value_, bytes memory signature) external virtual;

    function getValue() external view returns (uint256) {
        return value;
    }

    function getMessageOwner() external view returns (address) {
        return messageOwner;
    }
}

contract ValueSetter is AuthorizedValue {

    string contractName = "ValueSetter";
    uint64 sepoliaChainId = 11155111;

    function setValue(uint256 value_, bytes memory signature) external override {
        (bytes32 r, bytes32 s, uint8 v) = getSigParams(signature);
        bytes32 hashMessage = keccak256(abi.encode(value_, sepoliaChainId, contractName));
        bytes32 signedMessage = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hashMessage));
        AuthorizedValue.setValueRaw(value_, signedMessage, r, s, v);
    }

    function getSigParams(bytes memory signature) internal pure returns (bytes32, bytes32, uint8) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        return(r, s, v);
    }
}

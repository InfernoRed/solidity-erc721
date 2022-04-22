// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library Helpers {
    function concatenateStrings(string memory self, string memory other)
        internal
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(self, other));
    }

    function getUri(string memory self)
        internal
        pure
        returns (string memory)
    {
        string memory prefix = "ipfs://";
        return concatenateStrings(prefix, self);
    }
}

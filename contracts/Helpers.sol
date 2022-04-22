// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../lib/Helpers.sol";

// TODO: Do we need to build test contracts JUST for unit testing libraries?
contract HelperLibraryTest {
    function concatenateStrings(string memory self, string memory other)
        public
        pure
        returns (string memory)
    {
        return Helpers.concatenateStrings(self, other);
    }

    function getUri(string memory self)
        public
        pure
        returns (string memory)
    {
        return Helpers.getUri(self);
    }
}
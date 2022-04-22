// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "../lib/Helpers.sol";

contract Token is ERC721 {
    string private baseUri;

    constructor(string memory uri) ERC721("Token", "MTK") {
        baseUri = uri;
    }

    // Apparently we need to use View instead of pure here,
    // because we need to read from baseUri.
    function _baseURI() internal view override returns (string memory) {
        return Helpers.getUri(baseUri);
    }
}

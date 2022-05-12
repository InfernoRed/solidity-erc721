// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "../lib/Helpers.sol";

uint256 constant maxTokensPerTransaction = 5;
uint256 constant internalSupply = 100;
address constant mintAddress = 0x697fB223656dEa2b0EFCCfc6FBFc1CE4E7224843;

contract Token is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private tokenIDs;
    string private baseUri;

    constructor(string memory uri) ERC721("Token", "IRT") {
        tokenIDs.increment();
        baseUri = uri;

        // TODO: move address to config
        mintInternalTokens(mintAddress);
    }

    function mintInternalTokens(address to) internal {
        for (uint256 i = 0; i < internalSupply; i++) {
            _safeMint(to, tokenIDs.current());
            tokenIDs.increment();
        }
    }

    // Apparently we need to use View instead of pure here,
    // because we need to read from baseUri.
    function _baseURI() internal view override returns (string memory) {
        return Helpers.getUri(baseUri);
    }
}

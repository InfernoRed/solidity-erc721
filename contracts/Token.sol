// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "../lib/Helpers.sol";

contract Token is ERC721, IERC721Enumerable {
    using Counters for Counters.Counter;

    mapping(address => uint256[]) private ownerTokenIndexes;
    mapping(uint256 => uint256) private tokenIndex;

    uint256 private constant MAX_TOKENS_PER_TRANSACTION = 5;
    address private constant INTERNAL_ADDRESS =
        0x697fB223656dEa2b0EFCCfc6FBFc1CE4E7224843;
    uint256 private constant INTERNAL_SUPPLY = 100;

    Counters.Counter private supplyCounter;
    string private baseUri;

    constructor(string memory uri) ERC721("Token", "IRT") {
        baseUri = uri;

        // TODO: move address to config
        mintInternalTokens(INTERNAL_ADDRESS);
    }

    function mintInternalTokens(address to) internal {
        mintTokens(to, INTERNAL_SUPPLY);
    }

    function mint(address to, uint256 count) public {
        require(count <= MAX_TOKENS_PER_TRANSACTION, "Too many tokens to mint");
        mintTokens(to, count);
    }

    function mintTokens(address to, uint256 amount) internal {
        for (uint256 i = 0; i < amount; i++) {
            mintToken(to, totalSupply());
            supplyCounter.increment();
        }
    }

    function mintToken(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId);
        tokenIndex[tokenId] = tokenId;
        ownerTokenIndexes[to].push(tokenId);
    }

    // Apparently we need to use View instead of pure here,
    // because we need to read from baseUri.
    function _baseURI() internal view override returns (string memory) {
        return Helpers.getUri(baseUri);
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        override
        returns (uint256)
    {
        require(balanceOf(owner) > index, "index out of range");
        return ownerTokenIndexes[owner][index];
    }

    function totalSupply() public view override returns (uint256) {
        return supplyCounter.current();
    }

    // Assume no burning of tokens.
    // QUESTION: Can you reject without a return?
    function tokenByIndex(uint256 index)
        external
        view
        override
        returns (uint256)
    {
        require(index >= 0 && index <= totalSupply(), "invalid index");
        return tokenIndex[index];
    }
}

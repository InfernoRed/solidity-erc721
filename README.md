# Learn how to build NFT's with Solidity

In this course we will learn how to create and deploy a generative "10k"-style NFT smart contract on ethereum-based networks.

## What are we Doing?

Welcome to our very first self-guided course on Ethereum. In this course we will learn how to create and deploy a generative "10k"-style NFT smart contract on ethereum-based networks.

A generative "10k"-style NFT is a collection of artwork that is randomly generated from a predefined set of traits wherein some traits are statistically more rare than others. The 10k comes from a convention of limiting the supply to a maximum of 10-thousand units.

This style of project is excellent as an introduction to blockchain development because it's patterns are well-defined and easy to understand. Throughout this course we will use the real-world example of a 10k token drop as the substrate to learn concepts of solidity, blockchain, and ethereum development.

This course is self guided and can be completed individually or as a group. The first thing you should do is read this readme in it's entiretly before getting started. Each section has a github issue associated with it that includes more details and instructions. You can use this docuemnt as an outline and refer to the github issues for more details.

At a high level, we will use a framework library called [open zeppelin]() to create a simple [ERC-721 NFT]() contract and deploy it to the [rinkeby test network](https://www.rinkeby.io/#stats). We will extend the open zeppelin base ERC721 contracts with custom business logic for our token mint. 

Our token mint will include 1000 NFT tokens. The first 100 of the tokens are fixed and will be reserved for the team while the other 900 are randomly generated and will be purchaseable publically for .08 ETH each. The public purchase function will not be available right away and minting will not start until a designated time. Also the artwork will be hidden from users until after all of the items are sold out. This is a common pattern to use to ensure fairness so that users cannot game the blockchain to select their favorite generated NFT's (usually the "rare" ones). 

As we go along, we will be introduced to different core concepts of ethereum blockchain development. In this course we will explore the tools used to develop smart contracts including wallets, nodes, providers, smart contracts, gas, off-chain metadata, unit tests, debugging, security, and deploying to different networks. Ethereum development is similar to typescript development but there is a lot of nuance that is beyond the scope of this course; so don't worry about understanding everything all at once and just focus on the development patterns. 

## Implementation Steps

1. read this document in it's entirety
2. review the github issues as you go for more detail
3. create a new branch for your code
4. configure your environment for development
5. create the smart contract and test it locally
6. create the NFT token metadata and deploy it to IPFS
7. deloy the smart contract to rinkeby and test it on opensea
8. verify the contract on etherscan so that the source code can be checked
9. create a pull request against the main branch

## Getting Started

[ISSUE #1](https://github.com/InfernoRed/solidity-erc721/issues/1)

In order to begin we need to install the development stack. We will primarily use Hardhat and ethers.js to develop our smart contract. Installing hardhat will get us up and running very quickly as it automatically handles things like running a local node and downloading solidity compilers, etc. Links for tools are shared here at the top but will also be referenced where they are used.

### Ethereum Basics

[ISSUE #2](https://github.com/InfernoRed/solidity-erc721/issues/2)

- https://docs.soliditylang.org/en/v0.8.13/
- https://docs.ethers.io/v5/concepts/
- https://blog.openzeppelin.com/a-gentle-introduction-to-ethereum-programming-part-1-783cc7796094/
- https://cryptozombies.io/ - development tutorial (using the truffle suite tools)
- https://docs.openzeppelin.com/contracts/4.x/ - open zeppelin framework (e.g. standard template library)
- https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737/
- https://www.youtube.com/watch?v=kCswGz9naZg
- https://consensys.github.io/smart-contract-best-practices/

### Developer Tools

[ISSUE #3](https://github.com/InfernoRed/solidity-erc721/issues/3)

We'll be using the following tools extensively so you should install them now.

- [Metamask Crypto Wallet](https://metamask.io/) - crypto wallet browser extension that manages keys/wallets, and acts as a "web3 provider" via injected javascript code and a built-in node provider. Metamask is also available for mobile.
- [VS Code Solidity Extension](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity) - solidity language support for VS Code.
- [hardhat](https://www.hardhat.org) - development framework for building blockchain apps
- [ethers.js](https://docs.ethers.io/v5/) - javascript library (included with hardhat) useful for working with ethereum
- [open zeppelin](https://docs.openzeppelin.com/contracts/4.x/) - application framework that includes many templates for different types of ethereum contracts

### Deployment Tools

[ISSUE #4](https://github.com/InfernoRed/solidity-erc721/issues/4)

We will also be using several third party tools to help make development easier. You can sign up for the services now, and we'll work through them later in the process.

- [Alchemy](https://www.alchemy.com) - ethereum node operator so that we do not need to run our own ethereum node.
- [Pinata](https://www.pinata.com) - ipfs node operator so that we do not need to run our own IPFS node to host metadata
- [Etherscan](https://etherscan.io/) - etherscan is a block explorer that shows everything that is going on with a public network.
- [Tenderly](https://tenderly.co/) - tenderly monitors contracts
- [EthTx.info](https://ethtx.info/) - a tool for decoding and working with transactions

## Development

[ISSUE #5](https://github.com/InfernoRed/solidity-erc721/issues/5)

initialize hardhat with an "advanced sample using typescript".

```bash

# launch the hardhat CLI
npx hardhat

# let hardhat install an 'Advanced Sample with Typescript' and all requested packages

```

Hardhat installs a `Greeter.sol` example contract. You can run `npx test` to verify the unit tests.

### Creating Smart Contracts

[ISSUE #6](https://github.com/InfernoRed/solidity-erc721/issues/6)

For each step in the `development` section, write the described code and create a unit test that validates the code you wrote.

if you haven't already, install the open zeppelin library

```
npm install --save-dev @openzepplin/contracts
```

Replace `Greeter.sol` with `Token.sol` and also replace the unit test file.

In `Token.sol` declare a new contract and inherit `ERC721` from the open zepplelin library. [Check out the smart contract wizard](https://docs.openzeppelin.com/contracts/4.x/wizard) for more examples and different configurations.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Token is ERC721 {
    constructor() ERC721("Token", "MTK") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://<replace_me_later>";
    }
}

```

- [] pass a base URI into the constructor and access it from a private member variable in the `_baseURI` function.

#### Customizing Contracts - Mint on Deploy

[ISSUE #7](https://github.com/InfernoRed/solidity-erc721/issues/7)

As a developer I would like to mint 100 tokens to a designated address when my contract is deployed so that the owner of the address can view the minted tokens in their wallet. 

Our contract must mint 100 tokens to a specific wallet when it is deployed. Add an internal function that will call the `_safeMint` function found in the `ERC721.sol` base contract. The function should accept an address as a parameter. Call the function from the contract constructor.

#### Customizing Contracts - Public Mint

[ISSUE #8](https://github.com/InfernoRed/solidity-erc721/issues/8)

As a user i would like to purchase up to 5 tokens per transaction so that I can save time and costs minting multiple tokens.

Create a new `mint` function that accepts a quantity as an argument and implement it.

- [] the function should require the caller to send enough ETH to cover the cost of the mint.
- [] the function should require that the caller does not exceed the quantity limit.
- [] minting multiple tokens should increment the token id in sequential order
- [] 

#### Customizing Contracts - Pause Mint

[ISSUE #9](https://github.com/InfernoRed/solidity-erc721/issues/9)

As a developer i would like to be able to start the mint at a predetermined time so that all buyers have a fair shot at minting the tokens.

For this feature, we'll implement another feature from open zepplin called [pauseable](https://docs.openzeppelin.com/contracts/4.x/api/security#Pausable). Add the `pausable` dependency to the declarations at the top of the solidity file and add the pauseable modifier to the mint function. Don't forget to inherit the Pauseable contract on your contract.

Additionally, we do not want everyone to be able to pause and unpause our contract, so we need to add the `ownable` modifier as well following the same pattern for Pauseable

- [] create a public `pause` function that `onlyOwner` can call.
- [] create a public `unpause` function that `onlyOwner` can call.
- [] mark the mint function as `whenNotPaused`.
- [] create unit tests to prove that only the contract owner can call pause/unpause
- [] create unit tests to prove that the mint function can ony be called when not paused


#### Customizing Contracts - Mint Reveal

[ISSUE #10](https://github.com/InfernoRed/solidity-erc721/issues/10)

As a user i would like to receive an unrevealed token immediately so that i have posession of my token but also have confidence that I have a fair shot at receiving a rare token. As a user i would like my unrevealed token to revleal it's artwork at some point in the future and for the developer to prove to me that it was distributed fairly so that i can verify I received the right token.

This process is called a `reveal` and in order to execute a reveal, we need to override the OZ `tokenURI` function to have an unrevealed and a revealed state.

- [] define an "unrevealed base URI" that is returned from `tokenURI` for all token Id's
- [] define a "revealed base URI" that returns a unique file in an IPFS folder for each token Id.
- [] create a function that allows setting the revealed base uri
- [] validate that only the contract owner can set the revealed base uri

####  Customizing Contracts - Withdraw Funds

[ISSUE #11](https://github.com/InfernoRed/solidity-erc721/issues/11)

As a developer or project owner i would like to be able to withdraw funds from the contract so that I don't look silly for forgetting to add a withdraw function!

Yes! this happens. There is no default `withdraw` function included in a contract deployment, so don't forget to add olne.

- [] create a withdraw function that allows the caller to transfer funds out of the contract
- [] validate that only the contract owner can withdraw

#### Customizing Contracts - Advanced Use Cases (optional)

[ISSUE #12](https://github.com/InfernoRed/solidity-erc721/issues/12)

<TODO>

#### Customizing Contracts - optimizing gas costs (optional)

[ISSUE #13](https://github.com/InfernoRed/solidity-erc721/issues/13)

The steps in this section are optional.

- proxy approval
- enumerable/ ERC-721A?

<TODO>

### Creating the Token Metadata

[ISSUE #1]() 

Create a folder called `data` in the root of the repository.

Refer to the [OpenSea Metadata Standards](https://docs.opensea.io/docs/metadata-standards) to learn how to create metadata for both your contract and a template for your tokens.

There are two templates that we need for metadata

## Debugging

[ISSUE #1]()

<TODO>

## Testing

[ISSUE #1]()

<TODO>

## Deployment

[ISSUE #1]()

<TODO>

## Acceptance Criteria

Create a pull request against the main branch that includes the information required to see your smart contract deployment.

<TODO>

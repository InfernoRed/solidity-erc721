import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test token contract", function () {
  before(async function () {
    this.tokenFactory = await ethers.getContractFactory("Token");
  });

  beforeEach(async function () {
    this.token = await this.tokenFactory.deploy("test");
    await this.token.deployed();
  });

  it("Verify address", async function () {
    expect(42).to.equal(await this.token.address.length);
  });

  it("Reported total supply is accurate for initial supply", async function () {
    expect(await this.token.totalSupply()).to.equal(100);
  });

  it("token by index retrieves correct token", async function () {
    expect(await this.token.tokenByIndex(0)).to.equal(0);
  });

  // QUESTION: This runs very slow (677ms). Any optimizations?
  it("tokenOfOwnerByIndex retrieves correct token", async function () {
    const initialSupply = 100;
    const address = this.token.ownerOf(0);
    for (let i = 0; i < initialSupply; i++) {
      expect(await this.token.tokenOfOwnerByIndex(address, i)).to.equal(i);
    }
  });

  it("mintTokens mints tokens to owner's balance", async function () {
    const tokensToMint = 5;
    const owner = this.token.ownerOf(0);
    const priorBalance = Number.parseInt(await this.token.balanceOf(owner));
    const currentSupply = Number.parseInt(await this.token.totalSupply());
    await this.token.mint(owner, tokensToMint);

    expect(await this.token.totalSupply()).to.equal(
      currentSupply + tokensToMint
    );
    expect(await this.token.balanceOf(owner)).to.equal(
      priorBalance + tokensToMint
    );
  });
});

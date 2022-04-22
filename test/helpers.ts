import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test helper library", function () {
  before(async function () {
    this.tokenFactory = await ethers.getContractFactory("HelperLibraryTest");
  });

  beforeEach(async function () {
    this.token = await this.tokenFactory.deploy();
    await this.token.deployed();
  });

  it("Verify getUri", async function () {
    expect(await this.token.getUri("test")).to.equal("ipfs://test");
  });

  it("Verify concatenateString", async function () {
    const test = "test";
    expect(`${test}${test}`).to.equal(
      await this.token.concatenateStrings(test, test)
    );
  });
});

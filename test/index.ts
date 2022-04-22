import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test helper library", function () {
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
});

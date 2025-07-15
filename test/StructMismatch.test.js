const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PoC 2 – Struct ABI Desync", function () {
  let claim;
  let factory;

  beforeEach(async () => {
    // Deploy BUILDClaim
    const ClaimFactory = await ethers.getContractFactory("BUILDClaim");
    claim = await ClaimFactory.deploy();
    await claim.deployed();

    // Deploy BUILDFactory with address of BUILDClaim
    const FactoryFactory = await ethers.getContractFactory("BUILDFactory");
    factory = await FactoryFactory.deploy(claim.address);
    await factory.deployed();
  });

  it("Fails silently due to external struct layout mismatch", async function () {
    // Simulate upgrade by adding a new field during storage
    await claim.setGlobalState(1, 100, 0, 800); // newField = 800

    // Now BUILDFactory reads it, but its ABI doesn't recognize newField
    const refund = await factory.getRefundableLoyalty(1);

    console.log("💥 Computed refundable loyalty:", refund.toString());

    // The ABI desync causes incorrect refund logic
    expect(refund).to.equal(100); // should fail: refund might actually be 900
  });
});

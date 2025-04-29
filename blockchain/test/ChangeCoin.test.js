const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("ChangeCoin (UUPS)", function () {
  let ChangeCoin, changeCoin, owner, addr1;

  beforeEach(async () => {
    [owner, addr1] = await ethers.getSigners();
    ChangeCoin = await ethers.getContractFactory("ChangeCoin");
    changeCoin = await upgrades.deployProxy(ChangeCoin, [], {
      initializer: "initialize",
      kind: "uups",
    });
    await changeCoin.waitForDeployment();
  });

  it("should initialize with 1 million tokens to owner", async function () {
    const totalSupply = await changeCoin.totalSupply();
    const name = await changeCoin.name();
    const symbol = await changeCoin.symbol();

    expect(name).to.equal("ChangeCoin");
    expect(symbol).to.equal("CNGX");
    expect(totalSupply).to.equal(ethers.parseUnits("1000000", 18));
    expect(await changeCoin.balanceOf(owner.address)).to.equal(totalSupply);
  });
});

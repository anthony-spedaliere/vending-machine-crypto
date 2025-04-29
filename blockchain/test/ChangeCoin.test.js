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

  it("ChangeCoin with symbol CNGX should initialize with 1 million tokens to owner", async function () {
    const totalSupply = await changeCoin.totalSupply();
    const name = await changeCoin.name();
    const symbol = await changeCoin.symbol();

    expect(name).to.equal("ChangeCoin");
    expect(symbol).to.equal("CNGX");
    expect(totalSupply).to.equal(ethers.parseUnits("1000000", 18));
    expect(await changeCoin.balanceOf(owner.address)).to.equal(totalSupply);
  });

  it("owner can mint tokens", async function () {
    const mintAmount = ethers.parseEther("1000");
    const initialTotalSupply = await changeCoin.totalSupply();
    const initialOwnerBalance = await changeCoin.balanceOf(owner.address);
    const initialAddr1Balance = await changeCoin.balanceOf(addr1.address);

    await changeCoin.mint(addr1.address, mintAmount);

    expect(await changeCoin.balanceOf(addr1.address)).to.equal(
      initialAddr1Balance + mintAmount
    );
    expect(await changeCoin.totalSupply()).to.equal(
      initialTotalSupply + mintAmount
    );
    expect(await changeCoin.balanceOf(owner.address)).to.equal(
      initialOwnerBalance
    );
  });

  it("non-owner cannot mint tokens", async function () {
    const mintAmount = ethers.parseEther("1000");
    await expect(
      changeCoin.connect(addr1).mint(addr1.address, mintAmount)
    ).to.be.revertedWithCustomError(changeCoin, "OwnableUnauthorizedAccount");
  });

  it("user can burn their own tokens", async function () {
    const transferAmount = ethers.parseEther("500");
    const burnAmount = ethers.parseEther("300");
    const expectedRemaining = ethers.parseEther("200");

    const initialTotalSupply = await changeCoin.totalSupply();
    const initialOwnerBalance = await changeCoin.balanceOf(owner.address);

    await changeCoin.transfer(addr1.address, transferAmount);
    await changeCoin.connect(addr1).burn(burnAmount);

    expect(await changeCoin.balanceOf(addr1.address)).to.equal(
      expectedRemaining
    );
    expect(await changeCoin.totalSupply()).to.equal(
      initialTotalSupply - burnAmount
    );
    expect(await changeCoin.balanceOf(owner.address)).to.equal(
      initialOwnerBalance - transferAmount
    );
  });

  it("cannot burn more tokens than balance", async function () {
    const transferAmount = ethers.parseEther("500");
    const burnAmount = ethers.parseEther("600");

    await changeCoin.transfer(addr1.address, transferAmount);
    await expect(
      changeCoin.connect(addr1).burn(burnAmount)
    ).to.be.revertedWithCustomError(changeCoin, "ERC20InsufficientBalance");
  });
});

/**
 * @title VendingMachine Test Suite
 * @author Anthony Spedaliere
 * @notice Tests for the VendingMachine ERC721 token implementation
 * @dev Tests cover
 */

const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("VendingMachine (UUPS)", function () {
  let VendingMachine, vendingMachine;

  /**
   * @notice Sets up a fresh contract instance before each test
   * @dev Deploys a new proxy contract for each test to ensure clean state
   */
  beforeEach(async () => {
    [owner, addr1, addr2] = await ethers.getSigners();
    VendingMachine = await ethers.getContractFactory("VendingMachine");
    vendingMachine = await upgrades.deployProxy(VendingMachine, [], {
      initializer: "initialize",
      kind: "uups",
    });
    await vendingMachine.waitForDeployment();
  });
});

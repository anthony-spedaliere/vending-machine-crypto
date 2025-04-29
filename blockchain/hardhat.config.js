/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-ignition");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomicfoundation/hardhat-ethers");

module.exports = {
  solidity: "0.8.28",
  paths: {
    ignition: "ignition",
  },
};

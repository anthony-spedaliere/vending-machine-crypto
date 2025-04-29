/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-ignition");
require("@openzeppelin/hardhat-upgrades");
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28",
  paths: {
    ignition: "ignition",
  },
  // networks: {
  //   sepolia: {
  //     url: "",
  //     accounts: "",
  //   },
  // },
};

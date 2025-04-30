import * as dotenv from "dotenv";
dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-ignition");
require("@openzeppelin/hardhat-upgrades");
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28",
  paths: {
    ignition: "ignition",
  },
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/${process.env.ALCHEMY_API_KEY}`,
      accounts: [process.env.ACCOUNT_PRIV_KEY],
    },
  },
};

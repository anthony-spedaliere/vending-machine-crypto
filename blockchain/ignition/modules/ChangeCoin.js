const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ChangeCoinModule", (m) => {
  // Deploy the ChangeCoin implementation contract
  const changeCoinImpl = m.contract("ChangeCoin");

  // Deploy the proxy contract with initialization data
  const changeCoinProxy = m.contract("ChangeCoinProxy", [
    changeCoinImpl,
    "0x8129fc1c",
  ]);

  // Return the deployed contracts
  return {
    changeCoinImpl,
    changeCoinProxy,
  };
});

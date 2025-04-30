const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ChangeCoinModule", (m) => {
  // Deploy the ChangeCoin implementation contract
  const changeCoinImpl = m.contract("ChangeCoin");

  // Encode the initialization data for the proxy
  const initData = changeCoinImpl.interface.encodeFunctionData("initialize");

  // Deploy the proxy contract
  const changeCoinProxy = m.contract("ChangeCoinProxy", [
    changeCoinImpl,
    initData,
  ]);

  // Return the deployed contracts
  return {
    changeCoinImpl,
    changeCoinProxy,
  };
});

const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("VendingMachineModule", (m) => {
  // Deploy the VendingMachine implementation contract
  const vendingMachineImpl = m.contract("VendingMachine");

  // Deploy the proxy contract with initialization data
  // The initialization data is the encoded call to initialize()
  const vendingMachineProxy = m.contract("VendingMachineProxy", [
    vendingMachineImpl,
    "0x8129fc1c", // This is the encoded initialize() function call
  ]);

  // Return the deployed contracts
  return {
    vendingMachineImpl,
    vendingMachineProxy,
  };
});

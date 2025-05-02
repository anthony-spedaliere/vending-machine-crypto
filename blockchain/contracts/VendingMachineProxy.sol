/**
 * @title VendingMachineProxy
 * @author Anthony Spedaliere
 * @notice This contract is the UUPS proxy for the VendingMachine implementation contract
 * @dev This proxy contract delegates all calls to the VendingMachine implementation contract
 * @dev The proxy uses the ERC1967 standard for upgradeable contracts
 * @dev All calls to this contract will be delegated to the implementation contract
 * @dev The implementation contract can be upgraded by the owner using UUPS pattern
 */

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;



contract VendingMachineProxy is ERC1967Proxy {
    /**
     * @notice Constructor for the proxy contract
     * @param implementation The address of the VendingMachine implementation contract
     * @param data The initialization data for the VendingMachine contract
     * @dev The data parameter should contain the encoded function call to initialize()
     * @dev This constructor will delegate the initialization call to the implementation contract
     */
    constructor(address implementation, bytes memory data) ERC1967Proxy(implementation, data) {}
}
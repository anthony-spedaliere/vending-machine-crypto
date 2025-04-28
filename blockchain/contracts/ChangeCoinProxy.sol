// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**
 * @title ChangeCoinProxy
 * @author Anthony Spedaliere
 * @notice This contract is the UUPS proxy for the ChangeCoin implementation
 * @dev This proxy contract delegates all calls to the ChangeCoin implementation
 */
contract ChangeCoinProxy is ERC1967Proxy {
    /**
     * @notice Constructor for the proxy contract
     * @param implementation The address of the ChangeCoin implementation contract
     * @param data The initialization data for the ChangeCoin contract
     */
    constructor(address implementation, bytes memory data) ERC1967Proxy(implementation, data) {}
} 
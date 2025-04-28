/**
 * @title Change Coin Contract
 * @author Anthony Spedaliere
 * @notice This contract implements a basic upgradeable ERC20 token using open zeppelin library.
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// libary imports
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { ERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";


contract ChangeCoin is Initializable, ERC20Upgradeable {
    /**
     * @notice initialize name of coin and coin symbol
     * @dev initialize function replaces the solidity constructor in OpenZeppelin upgradeable proxy pattern contracts 
     */
    function initialize() public initializer {
        __ERC20_init("ChangeCoin", "CNGX");
    }
}
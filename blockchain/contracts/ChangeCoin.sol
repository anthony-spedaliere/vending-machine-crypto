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
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";


contract ChangeCoin is Initializable, ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
    /**
     * @notice Initializes the contract with token details and sets up upgradeability
     * @dev This function replaces the constructor in upgradeable contracts
     * @dev __ERC20_init: Initializes the ERC20 token with name and symbol
     * @dev __UUPSUpgradeable_init: Initializes the UUPS upgradeability pattern
     * @dev __Ownable_init: Initializes ownership with the deployer as the owner
     * @dev Mints initial supply to the deployer
     */
    function initialize() public initializer {
        __ERC20_init("ChangeCoin", "CNGX");
        __UUPSUpgradeable_init();
        __Ownable_init(msg.sender);
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    /**
     * @notice Authorizes an upgrade to a new implementation
     * @dev This function is called by the UUPS proxy when an upgrade is attempted
     * @dev The onlyOwner modifier ensures only the contract owner can authorize upgrades
     * @param newImplementation The address of the new implementation contract
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner{}
}
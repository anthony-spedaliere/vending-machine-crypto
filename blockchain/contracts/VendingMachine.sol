/**
 * @title VendingMachine 
 * @author Anthony Spedaliere
 * @notice This contract implements a basic upgradeable ERC721 standard using open zeppelin library.
 */
// libary imports
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VendingMachine is Initializable, ERC721Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
    using Counters for Counters.Counter;
    
    // Token ID counter
    Counters.Counter private _tokenIdCounter;
    
    // Base URI for token metadata
    string private _baseTokenURI;
    
    // Maximum number of tokens that can be minted in a single batch
    uint256 public maxBatchSize;
    
    // Events
    event BaseURIUpdated(string baseURI);
    event BatchMintLimitUpdated(uint256 newLimit);

    /**
     * @notice Initializes the contract with token details and sets up upgradeability
     */
    function initialize() public initializer {
        __ERC721_init("VendingMachine", "VM");
        __UUPSUpgradeable_init();
        __Ownable_init(msg.sender);
        maxBatchSize = 100; // Set initial batch size limit
    }

    /**
     * @notice Authorizes an upgrade to a new implementation
     * @dev This function is called by the UUPS proxy when an upgrade is attempted
     * @dev The onlyOwner modifier ensures only the contract owner can authorize upgrades
     * @param newImplementation The address of the new implementation contract
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner{}

    /**
     * @notice Mints a new token to the specified address
     * @param to The address that will receive the minted token
     * @param tokenId The ID of the token to mint
     */
    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }

    /**
     * @notice Mints a new token with auto-incrementing ID
     * @param to The address that will receive the minted token
     * @return The ID of the newly minted token
     */
    function safeMint(address to) public returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }

    /**
     * @notice Updates the maximum batch size for minting
     * @param newLimit The new maximum batch size
     * @dev Only callable by the contract owner
     */
    function setMaxBatchSize(uint256 newLimit) public onlyOwner {
        require(newLimit > 0, "Batch size must be greater than 0");
        maxBatchSize = newLimit;
        emit BatchMintLimitUpdated(newLimit);
    }

    /**
     * @notice Mints multiple tokens to the specified address
     * @param to The address that will receive the minted tokens
     * @param amount The number of tokens to mint
     * @dev Reverts if amount exceeds maxBatchSize
     */
    function batchMint(address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= maxBatchSize, "Amount exceeds maximum batch size");
        
        // Get the current token ID before minting
        uint256 startTokenId = _tokenIdCounter.current();
        
        // Mint all tokens
        for (uint256 i = 0; i < amount; i++) {
            _tokenIdCounter.increment();
            _safeMint(to, startTokenId + i);
        }
    }

    /**
     * @notice Burns a token
     * @param tokenId The ID of the token to burn
     */
    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not token owner or approved");
        _burn(tokenId);
    }

    /**
     * @notice Sets the base URI for all token metadata
     * @param baseURI The new base URI
     * @dev This should point to where your metadata is hosted (e.g., IPFS gateway)
     */
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
        emit BaseURIUpdated(baseURI);
    }

    /**
     * @notice Returns the base URI for all token metadata
     * @return The base URI
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /**
     * @notice Returns the URI for a specific token
     * @param tokenId The ID of the token
     * @return The URI for the token
     * @dev The URI should point to a JSON file containing the token's metadata
     * @dev The JSON should follow the ERC721 metadata standard
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721: URI query for nonexistent token");
        string memory base = _baseURI();
        return bytes(base).length > 0 ? string(abi.encodePacked(base, tokenId.toString())) : "";
    }

    /**
     * @notice Returns the total number of tokens minted
     * @return The total number of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }
}
pragma solidity ^0.8.0;

/// @title LucID NFT Protocol
interface ILucID is ERC165 {
    /// @dev This emits when a new iNFT is minted
    event iNFTMinted(address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when ownership of any iNFT changes by any mechanism
    event iNFTTransfer(address indexed _from, address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when `_owner` exchanges ownership of the `_old` iNFT for ownership of
    ///   the `_new` iNFT
    event iNFTExchange(address indexed _owner, bytes32 indexed _old, bytes32 indexed _new);
    
    /// @notice Find the owner of an iNFT based on the sha-3 hash of its information
    /// @dev If no iNFT with the given hash exists, return the zero address.
    /// @param _infoHash The sha-3 hash of the information in an iNFT
    /// @return The address of the owner of the iNFT
    function ownerOf(bytes32 _infoHash) external view returns (address);
    
    /// @notice Transfers the ownership of an iNFT from one address to another address
    /// @dev Throw unless `msg.sender` is the current owner
    /// @dev Throw if `_to` is the zero address
    /// @dev Throw if `_infoHash` is not a valid iNFT
    /// @param _to New address which will own the iNFT
    /// @param _infoHash iNFT to transfer
    function transfer(address _to, bytes32 _infoHash) external payable;
    
    /// @notice Assign new iNFT to an address
    /// @dev Throw unless `msg.sender` is the account which created the smart contract
    /// @dev Throw if `_to` is the zero address
    /// @dev Throw if `_to` is the address which created the smart contract
    /// @dev In order to mint iNFT for an exchange, set address `_to` as the location of the 
    ///   current smart contract
    /// @param _to The address to assign the iNFT to
    /// @param _infoHash The hash of the personal information to be connected with the address
    function mintINFT(address _to, bytes32 _infoHash) external payable;
    
    /// @notice Creates new exchange for iNFT replacement
    /// @dev Throw unelss `msg.sender` is the `_owner` account or the account which created the smart contract
    /// @dev Throw if `_owner` doesn't own the `_old` token or if `_old` is not a valid token
    /// @dev Make sure the exchange ID is not taken already
    /// @param _owner Owner of the _old token
    /// @param _old Hash of the information in the old iNFT, which the `_owner` wishes to exchange
    ///   ownership with
    /// @param _new Hash of the information in the new iNFT, which the `_owner` wishes to exchange 
    ///   ownership for
    /// @return Byte array identifier for the exchange
    function createExchange(address _owner, bytes32 _old, bytes32 _new) external payable returns (bytes32);
    
    /// @notice Addresses call this function to consent to a certain exchange
    /// @dev Throw unelss `msg.sender` is the `_owner` account or the account which created the smart contract
    /// @dev Throw if exchange is already sealed
    /// @param _exchangeID Byte array identifier for the exchange
    function signExchange(bytes32 _exchangeID) external payable;
    
    /// @notice Seals an exchange for iNFT replacement, transferring the _new iNFT from its
    ///   temporary ownership in the smart contract to the `_owner` address, and transferring
    ///   the ownership of the `_old` iNFT to the smart contract
    /// @dev Throw unelss `msg.sender` is the `_owner` account or the account which created the smart contract
    /// @dev Throw if one party has not signed the exchange
    /// @dev Throw if the `_new` iNFT is not owned by the smart contract
    /// @dev Throw if the `_old` iNFT is not owned by the `_owner`
    /// @dev Throw if exchange is already sealed
    /// @param _exchangeID Byte array identifier for the exchange
    function sealExchange(bytes32 _exchangeID) external payable;
    
    /// @notice Name of issuing authority
    function name() external view returns (string memory);
    
    /// @notice Type of document the iNFTs represent
    function docType() external view returns (string memory);
}

interface ERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    ///  uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

pragma solidity ^0.8.0;

/// @title LucID NFT Protocol
interface LucID /* is ERC165 */ {
    /// @dev This emits when a new iNFT is minted
    event NewINFT(address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when ownership of any iNFT changes by any mechanism.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _infoHash);
    
    /// @dev This emits when _owner exchanges ownership of the _old token for ownership
    ///   of the _new token. 
    event Exchange(address indexed _owner, bytes32 _old, bytes32 _new);

    /// @notice Count all iNFTs assigned to an owner (by current contract)
    /// @param _owner An address for whom to query the balance
    /// @return The number of iNFTs owned by `_owner`, possibly zero
    function iNFTsOf(address _owner) external view returns (uint256);

    /// @notice Find the owner of an iNFT based on the sha-3 hash of its information
    /// @dev If no iNFT with the given hash exists, return the zero address.
    /// @param _infoHash The sha-3 hash of the information in an iNFT
    /// @return The address of the owner of the iNFT
    function ownerOf(bytes32 _infoHash) external view returns (address);
    
    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function transferFrom(address _from, address _to, bytes32 _infoHash) external payable;
    
    /// @notice Assign new iNFT to an address
    /// @dev Only the account which created the smart contract can call this function
    /// @dev For obvious security reasons, the address _to cannot be the account which
    ///   created the smart contract.
    /// @dev In order to mint iNFT for an exchange, set address _to as the location of the 
    ///   current smart contract
    /// @param _to The address to assign the iNFT to
    /// @param _infoHash The hash of the personal information to be connected with the address
    function mintINFT(address _to, bytes32 _infoHash) external payable;
    
    /// @notice Creates new exchange for iNFT replacement
    /// @dev Only the _owner account or the account which created the smart contract
    ///   can call this function
    /// @dev Address _owner must own the _old token
    /// @dev Make sure the exchange ID is not taken already
    /// @param _owner Owner of the _old token
    /// @param _old Hash of the information in the old iNFT, which the _owner wishes to exchange
    ///   ownership with
    /// @param _new Hash of the information in the new iNFT, which the _owner wishes to exchange 
    ///   ownership for
    /// @return Numerical exchange ID
    function createExchange(address _owner, bytes32 _old, bytes32 _new) external payable returns (uint256);
    
    /// @notice Addresses call this function to consent to a certain exchange
    /// @dev Only the accounts which created the exchange can call this function
    /// @param _bondID Numerical exchange ID
    function signExchange(uint256 _bondID) external payable;
    
    /// @notice Seals an exchange for iNFT replacement, transferring the _new iNFT from its
    ///   temporary ownership in the smart contract to the _owner address, and transferring
    ///   the ownership of the _old iNFT to the smart contract
    /// @dev Only the accounts which created the exchange can call this function
    /// @dev Throw if one party has not signed the exchange
    /// @dev Throw if the _new iNFT is not owned by the smart contract
    /// @dev Throw if the _old iNFT is not owned by the _owner
    /// @param _bondID Numerical exchange ID
    function sealExchange(uint256 _bondID) external payable;
    
    /// @notice Name of issuing authority
    function name() external view returns (string _name);
    
    /// @notice Type of document the iNFTs represent
    function docType() external view returns (string _docType);
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

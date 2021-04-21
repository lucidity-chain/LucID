pragma solidity ^0.8.0;

contract LucID {
    // @dev This emits when a new iNFT is minted
    event NewINFT(address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when ownership of any iNFT changes by any mechanism.
    event iNFTTransfer(address indexed _from, address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when `_owner` exchanges ownership of the `_old` iNFT for ownership of the `_new` iNFT. 
    event iNFTExchange(address indexed _owner, bytes32 indexed _old, bytes32 indexed _new);
    
    struct Exchange {
        address oldOwner;
        bytes32 oldINFT;
        bytes32 NewINFT;
        bool ownerSigned;
        bool creatorSigned;
    }
    
    mapping(bytes32 => address) private _ownership;
    mapping(bytes32 => Exchange) private _exchanges;
    
    address private _creatorAddr;
    address private _contractAddr;
    
    string private _name;
    string private _docType;
    
    constructor (string memory name_, string memory docType_) {
        _creatorAddr = msg.sender;
        _contractAddr = address(this);
        _name = name_;
        _docType = docType_;
    }
    
    
    function ownerOf(bytes32 _infoHash) external view returns (address) {
        return _ownership[_infoHash];
    }
    
    function transfer(address _to, bytes32 _infoHash) external payable {
        require(msg.sender == _ownership[_infoHash], "You don't own this, so don't pass it around!");
        require(_to != address(0), "The zero address isn't a good place to send stuff to!");
        require(_ownership[_infoHash] != address(0), "You can't send something that hasn't be created yet!");
        _ownership[_infoHash] = _to;
        emit iNFTTransfer(msg.sender, _to, _infoHash);
    }
    
    function mintINFT(address _to, bytes32 _infoHash) external payable {
        require(msg.sender == _creatorAddr, "Hey, you don't own the priveleges to creat iNFTs yet!");
        require(_to != address(0), "Don't create iNFTs for the zero address!");
        require(_to != _creatorAddr, "You can't abuse this system. Don't even try creating IDs for yourself.");
        _ownership[_infoHash] = _to;
        emit NewINFT(_to, _infoHash);
    }
    
    function name() external view returns (string memory) {
        return _name;
    }
    
    function docType() external view returns (string memory) {
        return _docType;
    }
}

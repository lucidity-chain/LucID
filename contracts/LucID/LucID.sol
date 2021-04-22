pragma solidity ^0.8.0;

contract LucID {
    // @dev This emits when a new iNFT is minted
    event iNFTMinted(address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when ownership of any iNFT changes by any mechanism.
    event iNFTTransfer(address indexed _from, address indexed _to, bytes32 indexed _infoHash);
    
    /// @dev This emits when `_owner` exchanges ownership of the `_old` iNFT for ownership of the `_new` iNFT. 
    event iNFTExchange(address indexed _owner, bytes32 indexed _old, bytes32 indexed _new);
    
    struct Exchange {
        address iNFTOwner;
        bytes32 oldINFT;
        bytes32 newINFT;
        bool ownerSigned;
        bool creatorSigned;
        bool exchangeSealed;
    }
    
    mapping(bytes32 => address) private _ownership;
    mapping(bytes32 => Exchange) private _exchanges;
    
    address private _creatorAddr;
    address private _contractAddr;
    
    string private _name;
    string private _docType;
    
    uint256 _nonce;
    
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
        emit iNFTMinted(_to, _infoHash);
    }
    
    function createExchange(address _owner, bytes32 _old, bytes32 _new) external payable returns (bytes32) {
        require(msg.sender == _owner || msg.sender == _creatorAddr, "You don't have the priveleges to create this exchange!");
        require(_ownership[_old] == _owner, "You can't exchange something you don't own!");
        
        Exchange memory newExchange = Exchange(_owner, _old, _new, false, false, false);
        bytes32 newExchangeID = keccak256(abi.encodePacked(_nonce, _owner, _old, _new));
        _exchanges[newExchangeID] = newExchange;
        emit iNFTExchange(_owner, _old, _new);
        return newExchangeID;
    }
    
    function signExchange(bytes32 _exchangeID) external payable {
        Exchange memory currentExchange = _exchanges[_exchangeID];
        require(msg.sender == currentExchange.iNFTOwner || msg.sender == _creatorAddr,
                "You don't have the priveleges to sign this exchange!");
        require(currentExchange.exchangeSealed == false, "You can't signed a sealed exchange!");
        
        if (msg.sender == currentExchange.iNFTOwner) currentExchange.ownerSigned = true;
        else currentExchange.creatorSigned = true;
    }
    
    function sealExchange(bytes32 _exchangeID) external payable {
        Exchange memory currentExchange = _exchanges[_exchangeID];
        require(msg.sender == currentExchange.iNFTOwner || msg.sender == _creatorAddr,
                "You don't have the priveleges to seal this exchange!");
        require(currentExchange.ownerSigned == true, "Owner of the old iNFT hasn't signed yet!");
        require(currentExchange.creatorSigned == true, "Smart contract creator hasn't signed yet!");
        require(_ownership[currentExchange.newINFT] == _contractAddr,
                "New iNFT hasn't been delivered to this smart contracy address yet!");
        require(_ownership[currentExchange.oldINFT] == currentExchange.iNFTOwner,
                "Owner does not actually own the old iNFT!");
        require(currentExchange.exchangeSealed == false, "You can't re-seal a sealed exchange!");
        
        _ownership[currentExchange.oldINFT] = _contractAddr;
        _ownership[currentExchange.newINFT] = currentExchange.iNFTOwner;
        currentExchange.exchangeSealed = true;
    }
    
    function name() external view returns (string memory) {
        return _name;
    }
    
    function docType() external view returns (string memory) {
        return _docType;
    }
}

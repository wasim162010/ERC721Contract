
pragma solidity ^0.8.0;

// import './ERC721.sol';
// import './Ownable.sol';
// import './Counters.sol';

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNFT is ERC721, Ownable {
    
    
    using Strings for uint256;
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;

    //user id to token id mapping, to find the owner of the token.
    mapping (address => uint256) private _tokenOwner;

    address _owner;

    event MintWithUSD(address userId, string cardId, string edition, string tokenURI, uint256 newTokenId);
    
    event MintWithETH(string cardId, string edition, string tokenURI, uint256 newTokenId);

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {
        _owner = msg.sender;
    }
    

    
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {//need to check
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /*

        1. If user pays in USD, then contract user will mint the NFT[mintWithUSD()]
        2. If user pays in ETH, then user can mint the NFT[ mintWithETH() ]


    */
    
    
    function mintWithUSD(address userId, string memory  cardId, string memory edition, string memory tokenURI) public returns(uint256) {
        
        require(msg.sender == _owner,"only Dbilia can mint"); //contract owner wl be minting the NFT.
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _tokenOwner[userId] = newItemId;
        mintToken(userId, newItemId, tokenURI);
        emit MintWithUSD(userId, cardId, edition, tokenURI, newItemId);
        return newItemId;
        
    }
    
    function mintWithETH(string memory  cardId, string memory edition, string memory tokenURI) public returns(uint256) {
        
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        mintToken(msg.sender, newItemId, tokenURI);
        emit MintWithETH(cardId, edition, tokenURI, newItemId);
        return newItemId;
        
    }

    function mintToken(
        address _to,
        uint256 _tokenId,
        string memory tokenURI_
    ) internal {
        
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, tokenURI_);
        
    }
}

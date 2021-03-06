// SPDX-License-Identifier: GPLv3
pragma solidity >=0.8.0;

import "./ERC721.sol";

contract MinterNft is ERC721{

    mapping(uint256 => string) public tokenURIs;

    mapping(uint256 => uint256) public mintIdToTokenId;

    address public owner;

    uint256 public nextId;

    modifier onlyOwner(){
        require(msg.sender == owner, "NOT AUTHORIZED");
        _;
    }

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {
        owner = msg.sender;
        nextId = 1;
    }

    function setOwner(address _newOwner)
        external
        onlyOwner
    {
        owner = _newOwner;
    }

    function mint(address _to, uint256 _mintId)
        public
        onlyOwner
    {
        _safeMint(_to, nextId);
        mintIdToTokenId[_mintId] = nextId;
        nextId++;
    }

    function mintAndSetURI(address _to, uint256 _mintId, string memory _uri)
        external
        onlyOwner
    {
        setTokenURI(nextId, _uri);
        mint(_to, _mintId);
    }

    function setTokenURI(uint256 _tokenId, string memory _uri)
        public
        onlyOwner
    {
        tokenURIs[_tokenId] = _uri;
    }

    function tokenURI(uint256 _tokenId)
        public
        override
        view
        returns (string memory)
    {
        return tokenURIs[_tokenId];
    }
}


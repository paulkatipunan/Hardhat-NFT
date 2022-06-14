// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721, Ownable, ERC721Enumerable {    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor(string memory _baseURI) ERC721("PenBl", "PNL") {
        baseURI = _baseURI;
    }
    
    string private baseURI;
    uint256 public maxSupply = 5;
    bool isDisabledSetUrl = false;

    function setBaseURI(string memory _baseURI) external onlyOwner {
        if (isDisabledSetUrl) {
            revert("disabled");
        }

        baseURI = _baseURI;
    }

    function disableSetBaseURI() external onlyOwner {
        isDisabledSetUrl = true;
    }

    function batchMint(uint256 _mintQty) public {
        require(totalSupply() + _mintQty <= maxSupply, "Token Supply Exceed");
        
        for (uint256 i = 1; i <= _mintQty; i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            //check if token is already minted
            if (!_exists(tokenId)) {
                _safeMint(_msgSender(), tokenId);
            } else {
                _mintQty++;
                continue;
            }
        }
    }

    function reserveToken(address _to, uint256 _tokenId) external onlyOwner {
        require(_tokenId < maxSupply, "Token Supply Exceed");
        _safeMint(_to, _tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".json")): "";
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

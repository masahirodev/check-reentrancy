// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelinV4/contracts/token/ERC721/ERC721.sol";
import "@openzeppelinV4/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelinV4/contracts/security/ReentrancyGuard.sol";

contract TokenContract is ERC721, ERC721Enumerable, ReentrancyGuard {
    uint256 private _nextTokenId;
    mapping(address => bool) isMinted;

    constructor() ERC721("MyToken", "MTK") {}

    function mint() public payable nonReentrant {
        require(!isMinted[msg.sender], "Already minted!");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        isMinted[msg.sender] = true;
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}

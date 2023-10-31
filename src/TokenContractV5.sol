// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract TokenContract is ERC721, ERC721Enumerable {
    uint256 private _nextTokenId;
    mapping(address => bool) isMinted;

    constructor() ERC721("MyToken", "MTK") {}

    function mint() public payable {
        require(!isMinted[msg.sender], "Already minted!");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        isMinted[msg.sender] = true;
    }

    // The following functions are overrides required by Solidity.
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}

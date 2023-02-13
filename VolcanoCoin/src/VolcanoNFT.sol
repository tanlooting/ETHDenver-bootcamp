// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./VolcanoCoin_v2.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extension/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract VolcanoNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 constant ETHMintRate = 10_000_000_000_000_000; // 0.01eth in wei
    uint256 constant VLCNMintRate = 1_000_000_000_000_000_000; // 1 eth?

    constructor() ERC721("Volcano", "VLCN") {}

    function mintNFT(
        address to,
        string memory tokenURI
    ) public payable returns (uint256) {
        require(msg.value >= ETHMintRate, "Insufficient Eth sent!");
        _safeMint(to, _tokenIds);
        _setTokenURI(_tokenIds, tokenURI);
        _tokenIds.increment();
        return _tokenIds;
    }

    function withdraw(uint256 amount) public onlyOwner {
        address _owner = owner();
        (bool success, ) = _owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer(
        address from,
        address to,
        Counters.Counter _tokenIds
    ) public {
        _transfer(from, to, _tokenIds);
    }

    function getTokenCounter() public view returns (uint256) {
        return _tokenIds;
    }
}

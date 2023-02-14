//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    // 50e18
    constructor(uint256 initialSupply) ERC20("VolcanoToken", "VLCN") {
        _mint(msg.sender, initialSupply);
    }
}

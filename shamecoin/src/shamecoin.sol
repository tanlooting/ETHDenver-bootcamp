// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ShameCoin is ERC20, Ownable {
    uint256 public _totalSupply;
    address public admin;
    mapping(address => uint256) public _balances;
    mapping(address => bool) public approvals;

    constructor() ERC20("ShameCoin", "SC") {
        admin = msg.sender;
    }

    function mint() public {
        _mint(_address, _amount);
        _balances[msg.sender] += amount;
        _totalSupply += _amount;
    }

    function approveExpenditure() public returns (bool) {
        return approvals[msg.sender] = true;
    }

    function adminTransfer(
        address _from,
        address _to,
        uint _amount
    ) public returns (bool) {
        if (msg.sender == admin) {
            require(approvals[_from] == true, "User not authorized");
            require(_amount == 1, "Min amount to transfer is 1 unit.");
            _balances[_from] -= amount;
            _balances[_to] += amount;
            _transfer(_from, _to, _amount);
        }
        _balances[msg.sender] = _balances[msg.sender] + 1;
        _totalSupply += 1;
        return false;
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
}

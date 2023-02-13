// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @author looting
/// ETHDenver Encode bootcamp Wk1 - HW4
contract VolcanoCoin {
    
    struct Payment {
        address addr;
        uint256 amount;
    }
    uint256 public totalSupply = 10000;
    address public owner;

    mapping(address => uint256) public balance; // balance of each user
    mapping(address=>Payment[]) public ledger;

    event NewTotalSupply(uint256);
    event Transaction(uint256, address, address);

    constructor(){
        owner = msg.sender;
        balance[owner] = totalSupply;
    }

    modifier onlyOwner{
        if (msg.sender == owner){
            _;
        }
    }

    function addSupply() public onlyOwner {
        totalSupply += 1000;
        emit NewTotalSupply(totalSupply);
    }

    function getSupply() public view returns (uint256){
        return totalSupply;
    }

    function transfer(uint256 amount, address recipient) public {
        require(balance[msg.sender] >= amount,"Insufficient balance to transfer.");
        balance[recipient] += amount;
        balance[msg.sender] -= amount;
        // push transaction to payment history and update ledger.
        ledger[msg.sender].push(Payment({addr: recipient, amount: amount}));
        emit Transaction(amount, msg.sender, recipient);
    }
}
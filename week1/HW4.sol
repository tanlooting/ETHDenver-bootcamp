// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @author looting
/// ETHDenver Encode bootcamp Wk1 - HW4
contract VolcanoCoin {
    uint256 public totalSupply;
    address public owner; // payable?
    mapping(address => uint256) public balance; // balance of each user
    struct Payment {
        address addr;
        uint256 amount;
    }

    mapping(address=>Payment[]) public ledger;

    event NewTotalSupply(uint256);
    event Transaction(uint256, address, address);

    constructor(){
        totalSupply = 10000;
        owner = msg.sender;
        balance[owner] = totalSupply;
    }

    modifier onlyOwner{
        if (msg.sender == owner){
            _;
        }
    }

    // only contract owner can add supply
    function addSupply() public onlyOwner {
        totalSupply += 1000;
        emit NewTotalSupply(totalSupply); // emit when totalSupply is changed.
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
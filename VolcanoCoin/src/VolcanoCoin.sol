// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @author looting
/// ETHDenver Encode bootcamp Wk1 - HW4
contract VolcanoCoin is Ownable{
    
    uint256 public totalSupply;
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
        balance[owner()] = totalSupply;
    }

    
    function addSupply() public onlyOwner {
        /// only contract owner can add supply
        totalSupply += 1000;
        emit NewTotalSupply(totalSupply); // emit when totalSupply is changed.
    }

    function getSupply() public view returns (uint256){
        return totalSupply;
    }

    function transfer(
        uint256 amount, 
        address recipient
        ) public {
        require(balance[msg.sender] >= amount,"Insufficient balance to transfer.");
        balance[recipient] += amount;
        balance[msg.sender] -= amount;
        // push transaction to payment history and update ledger.
        recordPayment(msg.sender, recipient, amount);
        emit Transaction(amount, msg.sender, recipient);
        }

    function recordPayment(
        address sender, 
        address recipient, 
        uint256 amount
        ) public {
            ledger[sender].push(Payment(recipient, amount));
        }

    function getPaymentRecords(address user) public view returns (Payment[] memory){
        /// why do we use memory here?
        return ledger[user];
    }
    function getBalance(address user) public view returns(uint256){
        return balance[user];
    }

}
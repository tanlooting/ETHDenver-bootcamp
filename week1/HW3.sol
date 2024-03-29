//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;


contract BootcampContract {

    address deployer;
    address burnAddress = address(0x000000000000000000000000000000000000dEaD);
    
    // update the variable with the deployer's address when the contract is deployed
    constructor(){
        deployer = msg.sender;
    }

    function retrieve() public view returns (address){
        return (msg.sender != deployer) ? deployer : burnAddress;
    }
}
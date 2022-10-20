//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;


contract BootcampContract {

    address public deployer;
    address public burnAddress = 0x000000000000000000000000000000000000dEaD;
    
    // update the variable with the deployer's address when the contract is deployed
    constructor(){
        deployer = msg.sender;
    }

    function retrieve() public view returns (address){
        if (msg.sender != deployer){
            return deployer;
        }
        else {
            return burnAddress;
        }
    }
}
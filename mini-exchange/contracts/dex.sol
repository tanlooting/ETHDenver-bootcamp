//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./token.sol";

contract Exchange {
    Token public token;
    uint256 public rate = 100; // ideally this rate should be based on an equation? consider AMM

    event TokensBought(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );
    event TokensSold(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );

    constructor(Token _token) {
        token = _token;
    }

    //ethToToken
    function buyTokens() public payable {
        uint256 tokenAmount = msg.value * rate;
        require(token.balanceOf(address(this)) >= tokenAmount);
        token.transfer(msg.sender, tokenAmount);
        emit TokensBought(msg.sender, address(token), tokenAmount, rate);

        bool sent = payable(address(this)).send(msg.value);
        require(sent, "Failed to send Ether");
    }

    //TokentoEth
    function sellTokens(uint256 _amount) public payable {
        require(token.balanceOf(msg.sender) >= _amount);

        uint256 etherAmount = _amount / rate;

        // liquidity pool need to have enough ether
        require(address(this).balance >= etherAmount);

        token.transferFrom(msg.sender, address(this), _amount);

        // (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        // require(callSuccess, "call failed");

        payable(msg.sender).transfer(etherAmount);
        emit TokensSold(msg.sender, address(token), _amount, rate);
    }

    receive() external payable {}

    fallback() external payable {
        // automatically routes to our fund function
    }

    // AMM function
    // function price() {}

    // get liquidity
    // function getLiquidity() {}

    // add liquidity
    // function addLiquidity() {}

    // remove liquidity
    // function removeLiquidity() {}
}

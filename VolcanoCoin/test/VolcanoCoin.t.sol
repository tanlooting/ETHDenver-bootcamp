// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCointest is Test {
    VolcanoCoin public volcanoCoin;
    address owner;

    function setUp() public {
        vm.startPrank(owner);
        volcanoCoin = new VolcanoCoin();
    }

    function testInitialSupply() public {
        /// initial supply has to be 10000
        uint totalSupply = volcanoCoin.getSupply();
        assertEq(totalSupply, 10000);
    }

    function testSupplyIncrement() public {
        /// supply increment has to be by 1000
        uint initialSupply = volcanoCoin.getSupply();
        volcanoCoin.addSupply();
        uint increment = volcanoCoin.getSupply() - initialSupply;
        assertEq(increment, 1000);
    }

    function testFailUserChangeSupply() public {
        vm.stopPrank();
        vm.startPrank(address(99));
        volcanoCoin.addSupply();
        /// only owner of contract can increase the supply
    }

    function testTransfer() public {
        volcanoCoin.transfer(100, address(666));
        assertEq(volcanoCoin.getBalance(address(666)), 100);
        assertEq(volcanoCoin.getBalance(owner), 9900);
    }
}

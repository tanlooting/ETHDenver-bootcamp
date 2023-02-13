// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTtest is Test {
    VolcanoNFT public volcanoNFT;
    address owner = address(99);

    function setUp() public {
        vm.startPrank(owner);
        volcanoNFT = new VolcanoNFT();
    }

    function testMint() public {
        volcanoNFT.mintNFT();
        assertEq(volcanoNFT.getTokenCounter(), 1);
    }
}

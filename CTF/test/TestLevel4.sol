// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {Level4} from "../src/Level4.sol";
import {console} from "forge-std/console.sol";

contract Level2Test is Test {
    Level4 public level4;

	function testUnpack() public { 
        level4 = new Level4();
        uint256 a = level4.solution(1);
        assertEq(a, 1);
        a = level4.solution(21);
        assertEq(a, 16);
        a = level4.solution(9223372036854775808);
        assertEq(a, 9223372036854775808);
    }

}
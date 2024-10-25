// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {Level3} from "../src/Level3.sol";
import {console} from "forge-std/console.sol";

contract Level2Test is Test {
    Level3 public level3;

	function testUnpack() public { 
        level3 = new Level3();
        uint16 a = uint16(213);
        bool b = true;
        bytes6 c;
        bytes memory e = abi.encodePacked(a, b, c);
        uint16 aa;
        bool bb;
        bytes6 cc;
        (aa, bb, cc) = level3.solution(e);
        assertEq(a, aa);
        assertEq(b, bb);
        assertEq(c, cc);
    }

    function test2() public{
        level3 = new Level3();
        bytes memory data = abi.encodePacked(uint16(10), true, hex"abcdef");
        (uint16 a, bool b, bytes6 c) = level3.solution(data);
        assertEq(a, 10);
        assertEq(b, true);
        assertEq(c, hex"abcdef");
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {Level5} from "../src/Level5.sol";
import {console} from "forge-std/console.sol";

contract Level5Test is Test {
    Level5 public level5;

	function testOverflow() public { 
        level5 = new Level5();
        int256 a = level5.solution(1, 2);
        assertEq(a, 2);
    }

	function testOverflow2() public { 
        level5 = new Level5();
        int256 a = level5.solution(-3, -2);
        assertEq(a, -3);
    }

	function testOverflow3() public { 
        level5 = new Level5();
        int256 a = level5.solution(-11, 3);
        assertEq(a, -4);
    }

    function testOverflow4() public {
        level5 = new Level5();
        int256 a = type(int256).max;
        int256 b = type(int256).max;
        int256 c = level5.solution(a, b);
        assertEq(c , a);
    }

    function testOverflow5() public {
        level5 = new Level5();
        int256 a = type(int256).min;
        int256 b = type(int256).min;
        int256 c = level5.solution(a, b);
        assertEq(c , a);
    }

    function testOverflow6() public {
        level5 = new Level5();
        int256 a = type(int256).max-1;
        int256 b = type(int256).min+1;
        int256 c = level5.solution(a, b);
        assertEq(c , 0);
    }

}
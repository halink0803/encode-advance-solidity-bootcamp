// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {Level2} from "../src/Level2.sol";
import {console} from "forge-std/console.sol";

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
    interface Isolution {
        function solution() external pure returns (uint8);
    }
*/

contract Level2Test is Test {
    Level2 public level2;

	function testSortedArray() public { 
        level2 = new Level2();
        // uint256[10] memory unsortedArray = [uint256(5), 6, 4, 8 ,1 ,2, 3, 9 , 9, 7];
        uint256[10] memory unsortedArray = [uint256(2), 2, 4, 2 ,2 ,2, 2, 9 , 9, 3];
        uint256[10] memory sortedArray = level2.solution(unsortedArray);
        assertEq(sortedArray[0], 2);
        assertEq(sortedArray[1], 2);
        assertEq(sortedArray[2], 2);
        assertEq(sortedArray[3], 2);
        assertEq(sortedArray[4], 2);
        assertEq(sortedArray[5], 2);
        assertEq(sortedArray[6], 3);
        assertEq(sortedArray[7], 4);
        assertEq(sortedArray[8], 9);
        assertEq(sortedArray[9], 9);
    }
}
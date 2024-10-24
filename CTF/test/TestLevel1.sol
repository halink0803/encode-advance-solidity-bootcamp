// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import {Level1} from "../src/Level1.sol";

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
    interface Isolution {
        function solution() external pure returns (uint8);
    }
*/

contract Level1Test is Test {
    Level1 public level1;

	function testMatrixAdd() public { 
        level1 = new Level1();
    }
}
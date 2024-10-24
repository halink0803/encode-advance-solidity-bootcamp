// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
    interface Isolution {
        function solution() external pure returns (uint8);
    }
*/

contract Level1 {

	function solution(
        uint256[2][3] calldata x, 
        uint256[2][3] calldata y
        ) external pure returns (uint256[2][3] memory finalRes){ 
        for (uint256 i; i < 2; i++) {
            for (uint256 j; j < 3; j++) {
                finalRes[i][j] = x[i][j] + y[i][j];
            }
        }
    }
}
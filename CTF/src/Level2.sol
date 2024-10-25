// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////


/* 
  interface Isolution2 {
    function solution(uint256[10] calldata unsortedArray) external returns (uint256[10] memory sortedArray);
  }
*/

contract Level2 { 
    function solution(uint256[10] calldata unsortedArray) external pure returns (uint256[10] memory sortedArray){
      sortedArray = unsortedArray;
      for(uint256 i; i < 10; i++ )
        for(uint256 j=i+1; j< 10; j++) {
          if (sortedArray[i] > sortedArray[j]) {
            (sortedArray[i], sortedArray[j]) = (sortedArray[j], sortedArray[i]);
          }
        }
    }
}
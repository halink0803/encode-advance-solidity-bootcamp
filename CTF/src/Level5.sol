// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
interface Isolution5 {
    function solution(int256 a, int256 b) external pure returns (int256);
}
*/

contract Level5{
    // Give an overflow-free method for computing the average, rounding up, of 2 signed integers, (a + b) / 2 
    // Your function will take 2 values (a,b) and return the average of these values
    // Keep in mind that you will be rounding the average up (ceil) NOT rounding down (floor)
    // Floor -> rounding towards zero
    // Ceil -> rounding away from zero
    function solution(int256 a, int256 b) external pure returns (int256 res) {
        res = (a / 2) + (b / 2);
        if (res == type(int256).max || res == type(int256).min) {
            return res;
        }
        res += (a % 2 == 1 || b % 2 == 1) ? int256(1) : int256(0);
    }
}
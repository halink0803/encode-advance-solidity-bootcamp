// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
}
*/

contract Level3 {
    function solution(bytes memory packed) external pure returns (uint16 a, bool b, bytes6 c) {
        assembly {    
            a := mload(add(packed, 2)) 
            b := mload(add(packed, 3)) 
        }

        // Copy the remaining bytes for `c`
        for (uint i = 0; i < packed.length - 3; i++) {
            c |= bytes6(packed[3 + i] & 0xFF) >> (i * 8);
        } 
    }
}
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
        // require(packed.length == 9, "Invalid data length");

        // Unpack `a` (uint16, 2 bytes)
        a = uint16(uint8(packed[0])) << 8 | uint16(uint8(packed[1]));

        // Unpack `b` (bool, 1 byte)
        b = (packed[2] != 0);

        // Unpack `c` (bytes6, 6 bytes)
        c = bytes6(
            (bytes1(packed[3]) | (bytes1(packed[4]) >> 8) | (bytes1(packed[5]) >> 16) | (bytes1(packed[6]) >> 24) | (bytes1(packed[7]) >> 32) | (bytes1(packed[8]) >> 40))
        );
    }
}
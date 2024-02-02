// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // your code here
        
        for (uint8 i = 0; i < 3; i++) {
            
            bool mark = true;
            // Check for horizontal win
            for (uint8 j = 0; j < 3; j++) {
                if (board[i][j] != 1) {
                    mark = false;
                    break;
                }
            }
            if (mark) {
                return true;
            }

            // Check for vertical win
            for (uint8 j = 0; j < 3; j++) {
                if (board[j][i] != 1) {
                    mark = false;
                    break;
                }
            }
            if (mark) {
                return true;
            }
        }

        // Check for diagonal win
        if (board[0][0] == 1 && board[1][1] == 1 && board[2][2] == 1) {
            return true;
        }
        if (board[0][2] == 1 && board[1][1] == 1 && board[2][0] == 1) {
            return true;
        }
        
        return false;
    }
}

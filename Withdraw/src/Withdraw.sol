// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Withdraw {
    // @notice make this contract able to receive ether from anyone and anyone can call withdraw below to withdraw all ether from it
    function withdraw() public payable {
        // your code here
        uint256 current_ether = address(this).balance;
        (bool sent, ) = msg.sender.call{value: current_ether}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {
        
    }
}

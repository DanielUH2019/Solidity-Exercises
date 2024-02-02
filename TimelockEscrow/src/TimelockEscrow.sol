// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    mapping(address => uint256) public buyersEscrowedAmount;
    mapping(address => uint256) public escrowEndTime;

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(escrowEndTime[msg.sender] == 0 || escrowEndTime[msg.sender] < block.timestamp, "Last escrow hasn't been withdrawn");
        buyersEscrowedAmount[msg.sender] = msg.value;
        escrowEndTime[msg.sender] = block.timestamp + 3 days;

    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller, "You are not the seller");
        require(escrowEndTime[buyer] < block.timestamp, "Escrow time hasn't passed");
        (bool sent, ) = seller.call{value: buyersEscrowedAmount[buyer]}("");
        require(sent, "Failed to send Ether");

    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(escrowEndTime[msg.sender] > block.timestamp, "Escrow time has passed");
        (bool sent, ) = msg.sender.call{value: buyersEscrowedAmount[msg.sender]}("");
        require(sent, "Failed to withdraw Ether");
        buyersEscrowedAmount[msg.sender] = 0;

    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return buyersEscrowedAmount[buyer];
    }
}

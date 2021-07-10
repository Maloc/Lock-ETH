// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Lock {
    event EthLocked(address user, uint256 numberOfBlock, uint256 amount);

    struct lockedInfo {
        uint256 blockNumber;
        uint256 amount;
    }

    mapping(address => lockedInfo) public users;

    function lockEther(uint256 _numberOfBlocks) public payable {
        require(_numberOfBlocks > 0);
        lockedInfo storage user = users[msg.sender];
        user.blockNumber = block.number + _numberOfBlocks;
        user.amount = msg.value;
        emit EthLocked(msg.sender, user.blockNumber, user.amount);
    }

    function withdraw() public {
        require(block.number >= users[msg.sender].blockNumber);
        require(users[msg.sender].amount >= 1);
        lockedInfo storage user = users[msg.sender];
        uint256 value = user.amount;
        user.blockNumber = 0;
        user.amount = 0;
        address payable sender = payable(msg.sender);
        sender.transfer(value);
    }
}

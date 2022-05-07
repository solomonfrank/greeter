//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract PiggyBank {
    address public owner = msg.sender;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Forbidden");
        emit Withdraw(address(this).balance);
        // destroy the contract and send the available ether to the owner;
        selfdestruct(payable(msg.sender));
    }
}

//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name = "my token";
    string public symbol = "MYT";
    uint256 public decimals = 6;
    uint256 public totalSupply = 1000000 * (10**decimals);
    mapping(address => uint256) balances;

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function transfer(address receiver, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough fund");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

    function balanceOf(address owner) external view returns (uint256) {
        return balances[owner];
    }
}

//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    uint256 public decimal = 6;
    uint256 public totaSupply = 100000 * (10**decimal);

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, totaSupply);
    }
}

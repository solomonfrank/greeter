//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "./IERC20.sol";

contract Erc20 is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) allowance;
    string public name = "Test";
    string public symbol = "Test";
    uint256 public decimal = 18;

    function transfer(address _recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[_recipient] += amount;

        emit Transfer(msg.sender, _recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address _sender,
        address receiver,
        uint256 amount
    ) external returns (bool) {
        allowance[_sender][msg.sender] -= amount;
        balanceOf[_sender] -= amount;
        balanceOf[receiver] += amount;
        emit Approve(_sender, receiver, amount);
        return true;
    }

    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}

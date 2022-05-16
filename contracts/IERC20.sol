//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address _owner) external view returns (uint256);

    function transfer(address _recipient, uint256 amount)
        external
        returns (bool);

    function transferFrom(
        address _sender,
        address receiver,
        uint256 amount
    ) external returns (bool);

    function allowance(address owner, address spender)
        external
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    event Transfer(address from, address to, uint256 amount);
    event Approve(address owner, address spender, uint256 amount);
}

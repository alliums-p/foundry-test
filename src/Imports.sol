pragma solidity ^0.8.0;

import "solmate/tokens/ERC20.sol";

contract Token is ERC20("Test", "Ttoken", 18) {}

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestOz is Ownable {}
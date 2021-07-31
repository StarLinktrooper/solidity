// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;

// import 'https://github.com/OpenZeppelin/openZeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol';
// import 'https://github.com/OpenZeppelin/openZeppelin-contracts/blob/v4.0.0/contracts/utils/math/SafeMath.sol';

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Token is ERC20 {
  using SafeMath for uint;
  address public owner;
  uint public maxTotalSupply;

  constructor(
    string memory name, 
    string memory symbol,
    uint _maxTotalSupply
  ) ERC20(name, symbol) {
    owner = msg.sender;
    maxTotalSupply = _maxTotalSupply;
  }

  function transferOwner(address newOwner) external {
    require(msg.sender == owner, 'only owner');
    owner = newOwner;
  }

  function mint(address account, uint256 amount) external {
    require(msg.sender == owner, 'only admin');
    uint totalSupply = totalSupply();
    require(
      totalSupply.add(amount) <= maxTotalSupply, 
      'above maxTotalSupply limit'
    );
    _mint(account, amount);
  }
}
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SharedWallet is Ownable{
  mapping(address => uint) public allowance;

  function addAllowance(address _who, uint _amount) public onlyOwner {
    allowance[_who] = _amount;
  }
  
  modifier ownerOrAllowed(uint _amount) {
    require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are not allowed! ");
    _;
  }
  }

  function withdrawMoney(address payable _to, uint256 _amount) public ownerOrAllowed(_amount) {
        _to.transfer(_amount);
    }

    receive() external payable {}
}

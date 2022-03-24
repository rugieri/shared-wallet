//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    event AllowanceChanged(
        address indexed _forWho,
        address indexed _byWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );
    mapping(address => uint256) public allowance;

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
}

contract SharedWallet is Ownable, Allowance {
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "Contract doesn't own enough money"
        );
        if (msg.sender != owner()) {
            reduceAllowance(msg.sender, _amount);
        }

        _to.transfer(_amount);
    }

    receive() external payable {}
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint256;
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

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            msg.sender == owner() || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount)
        internal
        ownerOrAllowed(_amount)
    {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub(_amount);
    }

    function renounceOwnership() public view override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
}

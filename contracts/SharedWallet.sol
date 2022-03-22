//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract SharedWallet {
    function withdrawMoney(address payable _to, uint256 _amount) public {
        _to.transfer(_amount);
    }

    receive() external payable {}
}

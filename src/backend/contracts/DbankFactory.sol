// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Store.sol';
import './Dbank.sol';

contract DbankFactory is Store{
    address public owner;

    modifier restrict{
        require(msg.sender == owner, "Only accesible to owner");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function addBank(uint rate, address bankId) public{
        address bank = address(new Dbank(rate, bankId));
        banks.push(bankId);
    }

    function addUser(address payable _user) public restrict{
        users[_user].kyc = true;
        users[_user].blacklist = false;
    }

    function getBankList() public view returns(address[] memory){
        return banks;
    }
}
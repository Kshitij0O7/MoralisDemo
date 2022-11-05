// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './implementations/Vault.sol';
import "@openzeppelin/contracts/access/Ownable.sol";

contract Store{
    struct status{
        bool kyc;
        bool blacklist;
    }
    mapping (address => status) public users;
    address payable[] public banks;
}
contract DbankFactory is Store{
    address private owner;  

    modifier restrict{
        require(msg.sender == owner, "Only accesible to owner");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function addBank(uint rate, address bankId) public restrict{
        address bank = address(new Dbank(rate, bankId));
        banks.push(payable((bank)));
    }

    function getBankList() public view returns(address payable[] memory){
        return banks;
    }
}

contract Dbank is Store, Ownable{
    address public bank;
    Vault public vault;

    modifier restricted {
        require(msg.sender == bank, "Only approved by bank");
        _;
    }
    modifier auth{
        require(users[msg.sender].blacklist, "Blacklisted");
        require(users[msg.sender].kyc, "User not found");
        _;
    }
    
    constructor(uint256 rate, address _bank){
        bank = _bank;
        vault.setInterest(rate);
    }

    function addUser(address payable _user) public restricted{
        users[_user].kyc = true;
        users[_user].blacklist = false;
    }

    function takeLoan(uint256 _collateral) public payable auth{
        vault.deposit(_collateral);
    }

    function repay(uint256 _repayment) public payable{
        vault.withdraw(_repayment);
    }

    function buy(uint256 _amount) public payable auth{
        vault.buy(_amount);
    }

    function send(uint256 _pay, address reciever) public payable auth{
        require(users[reciever].kyc == true, "User not found");
        vault.send(_pay, reciever);
    }

    function showPrice(uint256 val) public view returns(uint256){
        uint256 currPrice = vault.getEthUSDPrice();
        return(val*currPrice);
    }
}    

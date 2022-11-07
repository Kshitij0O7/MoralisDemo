// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './implementations/Vault.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import './Store.sol';


contract Dbank is Store, Ownable{
    address public bank;
    Vault public vault;
    struct LoanTaken{
        address from;
        address to;
        uint256 rate;
        uint256 loanTaken;
        uint256 repaymentLeft;
    }
    LoanTaken[] public loans;
    //mapping(address => LoanTaken) loans;

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
        //emit LoanTaken(bank, msg.sender,vault.rate(), _collateral/2, _collateral/2);
        LoanTaken storage loan = loans.push();
        loan.from = bank;
        loan.to = msg.sender;
        loan.rate = vault.rate();
        loan.loanTaken = _collateral/2;
        loan.repaymentLeft = _collateral/2;
    }

    function repay(uint256 _repayment) public payable{
        vault.withdraw(_repayment);
        for(uint256 i = 0; i<loans.length; i++){
            if(loans[i].to == msg.sender){
                loans[i].repaymentLeft -= _repayment;
            }
        }
        //loans[index].repaymentLeft -= _repayment;
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

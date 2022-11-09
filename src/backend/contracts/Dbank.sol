// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './implementations/Vault.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import './Store.sol';
import './interfaces/IVault.sol';

contract Dbank is Store,Ownable{
    address public bank;
    Vault public vault;
    struct LoanTaken{
        address from;
        uint256 rate;
        uint256 loanTaken;
        uint256 repaymentLeft;
    }
    event Loan(
        address indexed from,
        address indexed to,
        uint256 rate,
        uint256 loanTaken,
        uint256 repaymentLeft
    );
    //LoanTaken[] public loans;
    mapping(address => LoanTaken) loans;
    //mapping(address => LoanTaken) loans;

    modifier restricted {
        require(msg.sender == bank, "Only approved by bank");
        _;
    }
    modifier auth{
        require(!users[msg.sender].blacklist, "Blacklisted");
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
        loans[msg.sender] = LoanTaken(
            bank, vault.rate(), _collateral/2, _collateral*(1+vault.rate()/100)*block.timestamp/31536000
        );
        emit Loan(bank, msg.sender,vault.rate(), _collateral/2, _collateral/2);
    }

    function repay(uint256 _repayment,address _user) public payable auth{
        vault.withdraw(_repayment, _user);
        loans[msg.sender].repaymentLeft -= _repayment;
        emit Loan(bank,
        msg.sender,
        vault.rate(),
        loans[msg.sender].loanTaken,
        loans[msg.sender].repaymentLeft
        );
    }

    function ban(address _user) public restricted{
        require(loans[_user].repaymentLeft >= 9*loans[_user].loanTaken/10, "User not a defaulter");
        users[_user].blacklist = true;
        vault.recover(bank);
        //payable(bank).transferFrom(vault.vaults[msg.sender], 2*loans[_user].loanTaken);
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

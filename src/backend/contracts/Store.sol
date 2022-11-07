// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Store{
    struct status{
        bool kyc;
        bool blacklist;
    }
    mapping (address => status) public users;
    address payable[] public banks;
}
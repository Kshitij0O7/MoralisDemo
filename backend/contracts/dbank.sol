// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Dbank {
    event Request(
        address borrower,
        string mailId,
        string description,
        bool kyc,
        bool approved
    );
    address public admin;
    uint256 public rate;
    uint256 public time;
    mapping(address => bool) public members;

    modifier restricted() {
        require(msg.sender == admin);
        _;
    }

    constructor(uint256 roi, address bankId) {
        admin = bankId;
        rate = roi;
    }
}

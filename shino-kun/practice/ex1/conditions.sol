pragma solidity ^0.4.25;

contract Conditions {
    string bankName;
    uint money;
    address owner;
    uint defaultMoney;

    struct Bank {
        string customer;
        uint money;
        address id;
    }
    struct TransactionsDict {
        address from;
        address to;
        uint value;
        uint time;
    }
    mapping (uint => TransactionsDict) transactions;
    mapping (address => Bank) banks;
    address[] listCustomers;

    // check owner
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
}
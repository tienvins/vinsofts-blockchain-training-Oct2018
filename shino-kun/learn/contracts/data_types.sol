pragma solidity ^0.4.25;
contract Types {
    bool myBool = false;
    int8 myInt = -128;
    uint myUint = 255;
    string myString;
    uint8[] myStringArr;

    byte myValue;
    bytes1 myBytes1;
    bytes32 myBytes32;

    // fixed256x8 myFixed = 1; // 255.0
    // ufixed myUfixed = 1;

    enum Action {ADD, REMOVE, UPDATE}
    Action myAction = Action.ADD;

    address myAddress;
    function AssignAddress() public{
        myAddress = msg.sender;
        myAddress.balance;
        myAddress.transfer(10);
    }

    uint[] myIntArr = [1,2,3];
    function addToArr() public{
        myIntArr.push(5);
        myIntArr.length;
        myIntArr[0];
    }

    uint[10] myFixedArr;

    struct Account {
        uint balance;
        uint dailylimit;
    }

    Account myAccount;
    function setBalance() public {
        myAccount.balance = 100;
    }

    mapping (address => Account) _accounts;
    function myMapping() payable public {
        _accounts[msg.sender].balance += msg.value;
    }

    function getBalance() returns (uint){
        return _accounts[msg.sender].balance;
    }


}
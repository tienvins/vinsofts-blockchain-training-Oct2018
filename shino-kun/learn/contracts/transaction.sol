pragma solidity ^0.4.25;
contract Transaction {
    event senderLogger(address);
    event valueLogger(uint);

    address private owner;
    function Transaction(){
        owner = msg.sender;
    }

    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }
    modifier validValue(){
        assert(msg.value >= 1 ether);
        _;
    }

    function () payable isOwner validValue {
        senderLogger(msg.sender);
        valueLogger(msg.value);
    }
}
pragma solidity ^0.4.25;

contract Mortal {
    address public owner;

    function mortal () public{
        owner = msg.sender;
    }

    modifier onlyOwner (){
        if (msg.sender != owner) {
            throw;
        }else {
            _
        }

    }

    function kill () public{
        suicide(owner);
    }
}

contract User is Mortal {
    string public userName;

    function user(string u){
        userName = u;
    }
}

contract Provider is Mortal {
    string public pName;

    function user(string u){
        pName = u;
    }
}
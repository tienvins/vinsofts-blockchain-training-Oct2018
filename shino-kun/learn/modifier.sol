pragma solidity ^0.4.25;
contract Mod {
    string word = "Hello world";
    address owner;

    function Mod(){
        owner = msg.sender;
    }
    function getWord() returns(string){
        return word;
    }

    function setWord(string w) returns(string){
        if (owner != msg.sender){
            return "You shall not pass";
        }
        word = w;
        return "setWord success";
    }
}
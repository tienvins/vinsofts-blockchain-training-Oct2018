pragma solidity ^0.4.25;
contract A {
    function sayName() returns(string);
}

contract B is A {
    string public name;
    function sayName() returns(string){
        return "shino";
    }
}
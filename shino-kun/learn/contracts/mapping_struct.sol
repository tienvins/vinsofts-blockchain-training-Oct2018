pragma solidity ^0.4.25;

contract Courses {
    struct Person {
        uint age;
        string fname;
        string lname;
    }

    mapping (address => Person) persons;
    address[] public _person;

    function setPerson(address _address, uint _age, string _fname, string _lname) public{
        var person = persons[_address];
        person.age = _age;
        person.fname = _fname;
        person.lname = _lname;

        _person.push(_address) -1;
    }

    modifier isPerson(address _address){
        if (persons[_address]) {
            _;
        }else{
            return "Not found data";
        }
    }

    function getAllPersons() view public returns (address[]){
        return _person;
    }

    function getPerson(address _address)  view public returns(uint, string, string){
        var person = persons[_address]; 
        return (person.age, person.fname, person.lname);
    }

    function countPersons() view public returns(uint){
        return _person.length;
    }
}
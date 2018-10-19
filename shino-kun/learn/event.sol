pragma solidity ^0.4.25;

contract MyEvent {
  string fName;
  uint age;

  event Instructor( string name, uint age);
  
  function setInstructor (string _fName, uint _age) public {
    fName = _fName;
    age = _age;
    emit Instructor(_fName, _age);
  }

  function getInstructor() view public returns (string, uint){
    return (fName, age);
  }
}
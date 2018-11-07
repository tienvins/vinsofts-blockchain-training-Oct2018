pragma solidity ^0.4.23;

contract Demo {
    string public name = "Shino kun";
    // address public owner = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    address public owner = msg.sender;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    function changeName(string _name) onlyOwner {
        name = _name;
    }

}
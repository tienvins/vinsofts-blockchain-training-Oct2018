pragma solidity ^0.4.25;

contract Token {
    uint public totalSupply;
    
    struct User{
        address owner;
        uint amount;
    }
    
    User[] users;
    
    mapping (address => User) toUser;
    mapping (address => mapping(address => uint)) allowed;
    
    constructor() {
        totalSupply=1000;
    }
    
    function register() public {
        User memory user = User(msg.sender,100);
        users.push(user);
        toUser[msg.sender] = user;
    }
    
    function balanceOf(address _owner) public returns(uint){
        return toUser[_owner].amount;
    }
    
    function balance() public returns(uint){
        return toUser[msg.sender].amount;
    }
    
    function Transfer(address _to, uint _money) public returns(bool success){
        toUser[msg.sender].amount -= _money;
        toUser[_to].amount += _money;
        return true;
    }
    
    function TransferFrom(address _from, address _to, uint _money) public returns(bool success){
        toUser[_from].amount -= _money;
        allowed[_from][msg.sender] -= _money; 
        toUser[_to].amount += _money;
        return true;
    }
    
    function approve(address _spender, uint _money) public returns (bool success){
        allowed[msg.sender][_spender] = _money;
        return true;
    }
    
    function allowance(address _owner, address _spender) public returns (uint) {
        return allowed[_owner][_spender];
    }
}
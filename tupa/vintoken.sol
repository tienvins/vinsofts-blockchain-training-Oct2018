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
    
    modifier checkAcc(){
        require(toUser[msg.sender].owner == msg.sender,"Bạn chưa có tài khoản");
        _;
    }
    modifier checkRigister(){
        require(toUser[msg.sender].owner != msg.sender,"Bạn đã có tài khoản");
        _;
    }
    modifier checkMoney(uint _money){
        require(toUser[msg.sender].amount >= _money, "Bạn ko đủ tiền");
        _;
    }
    modifier checkAllowance(address _from,uint _money){
        require(allowance(_from,msg.sender) >= _money,"Số token được ủy quyền  cho bạn nhỏ hơn số  bạn đang chọn ");
        _;
    }
    
    constructor() {
        totalSupply=1000;
    }
    
    function register() checkRigister public {
        User memory user = User(msg.sender,100);
        users.push(user);
        toUser[msg.sender] = user;
    }
    
    function balanceOf(address _owner) checkAcc public returns(uint){
        return toUser[_owner].amount;
    }
    
    function balance() checkAcc public view returns(uint){
        return toUser[msg.sender].amount;
    }
    
    function Transfer(address _to, uint _money) checkAcc checkMoney(_money) public returns(bool success){
        toUser[msg.sender].amount -= _money;
        toUser[_to].amount += _money;
        return true;
    }
    
    function TransferFrom(address _from, address _to, uint _money) checkAcc checkAllowance(_from,_money) public returns(bool success){
        toUser[_from].amount -= _money;
        allowed[_from][msg.sender] -= _money; 
        toUser[_to].amount += _money;
        return true;
    }
    
    function approve(address _spender, uint _money) checkAcc checkMoney(_money) public returns (bool success){
        allowed[msg.sender][_spender] = _money;
        return true;
    }
    
    function allowance(address _owner, address _spender) checkAcc public returns (uint) {
        return allowed[_owner][_spender];
    }
}
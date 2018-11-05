pragma solidity ^0.4.25;

//modifier by aris-vu
//overview: it's looking so good. great!!!
//firstly, using English for code, comment

contract Bank {
    string public bankName;
    uint amount;
    address owner;
    
    constructor(string _bankName) public {
        bankName = _bankName;
        amount = 1000;
        owner = msg.sender;
    }

    function changeNameBank(string _bankName) {
        require(msg.sender == owner);
        bankName = _bankName;
    }
    
    function infoBank() public view returns(string, uint, address){
        return (bankName, amount, owner);
    }
}

interface BankInterface {
    function transfer(address _to,uint _money);
    function withdraw(uint _money);
}

contract Bank2 is Bank {
    //when using struct, it should not be insert struct name in variable
    struct User {
        string userName; //need to be edit
        uint amountUser; //need to be edit
        address ownerUser; //need to be edit
    }
    
    User[] users;
    
    struct Transaction{
        address from;
        address to;
        uint value;
        uint timestamp;
    }
    
    //should we add 's', eg: transactions
    Transaction[] transaction;
    
    mapping (address => uint) OwnerToUserId;
    mapping (uint => address) UserIdToOwner;
    mapping (address => User) OwnerToUser;
    
    modifier checkAcc(){
        require(OwnerToUser[msg.sender].ownerUser !=0x0,"chua co tai khoan");
        _;
    }
    
    modifier checkMoney(uint _money){
        require(OwnerToUser[msg.sender].amountUser >= _money,"Khong du tien");
        _;
    }
    
    event EvGuiTienThanhCong(address from, address to, uint money);
    event EvRutTienThanhCong(address from, uint money);
    
    constructor (string _bankName) Bank(_bankName) public {
    }
    
    //should be using lowercase for first characters
    function Register(string _nameUser) public {
        User memory user = User(_nameUser, 1000, msg.sender);   //tao doi tuong
        uint id = users.push(user) - 1;
        amount += 1000;
        UserIdToOwner[id] = msg.sender;
        OwnerToUserId[msg.sender] = id;
        OwnerToUser[msg.sender] = user;
    }
    
    function infoUser() public view checkAcc() returns (string, uint) {
        User memory user = OwnerToUser[msg.sender];
        return (user.userName, user.amountUser);
    }
    
    function transfer(address _to, uint _money) checkAcc() checkMoney(_money){
        OwnerToUser[_to].amountUser += _money;
        OwnerToUser[msg.sender].amountUser -= _money;
        transaction.push(Transaction(msg.sender, _to, _money, uint(now)));
        EvGuiTienThanhCong(msg.sender, _to, _money);
    }
    
    function withdraw(uint _money) checkMoney(_money){
        OwnerToUser[msg.sender].amountUser -= _money;
        transaction.push(Transaction(msg.sender, 0 , _money, uint(now)));
        EvRutTienThanhCong(msg.sender, _money);
    }
    
    //so, as i know, this function return array id => so, how can i find detail of transaction?
    function getTransactionHistory() public view returns (uint[]) {
        uint[] memory data = new uint[](transaction.length);
        uint counter = 0;
        for(uint i=0; i < transaction.length; i++){
            if(transaction[i].from==msg.sender || transaction[i].to==msg.sender){
                data[counter]=i;
                counter++;
            }
        }
        return data;
    }
}
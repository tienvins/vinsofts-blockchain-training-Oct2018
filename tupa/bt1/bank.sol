pragma solidity ^0.4.25;

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
    function GuiTien(address _to,uint _money);
    function RutTien(uint _money);
}

contract Bank2 is Bank {
    struct User {
        string userName;
        uint amountUser;
        address ownerUser;
    }
    
    User[] users;
    
    struct Transaction{
        address from;
        address to;
        uint value;
        uint timestamp;
    }
    
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
    
    function DangKyUser(string _nameUser) public {
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
    
    function GuiTien(address _to, uint _money) checkAcc() checkMoney(_money){
        OwnerToUser[_to].amountUser += _money;
        OwnerToUser[msg.sender].amountUser -= _money;
        transaction.push(Transaction(msg.sender, _to, _money, uint(now)));
        EvGuiTienThanhCong(msg.sender, _to, _money);
    }
    
    function RutTien(uint _money) checkMoney(_money){
        OwnerToUser[msg.sender].amountUser -= _money;
        transaction.push(Transaction(msg.sender, 0 , _money, uint(now)));
        EvRutTienThanhCong(msg.sender, _money);
    }
    
    function GetTransactionHistory() public view returns (uint[]) {
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
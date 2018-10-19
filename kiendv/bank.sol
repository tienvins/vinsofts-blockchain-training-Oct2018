pragma solidity ^0.4.19;

contract Bank {
    string bankname;
    uint amount;
    address owner;
    
    constructor (string _bankname) public {
        bankname = _bankname;
        amount = 1000;
        owner = msg.sender;
        
    }
 
    function changeBankName(string newname) public {
        
        require(msg.sender==owner);
        bankname = newname;
    }
    
    function getInfoBank() public returns(string bn, uint am, address on){
        bn = bankname;
        am = amount;
        on = owner;
    }
}
interface Future {
    function guiTien(address nguoinhan);
    function rutTien(uint sotien, address owner);
    
}
contract Bank2 is Bank {
    
    struct User {
        string username;
        uint amount;
        address ownerUser;
        
    }
    User[] users;
    mapping(address => uint) OwnerToUserId;
    mapping(uint => address) UserIdToOwner;
    mapping(address => User) OwnerToUser;
    
    struct Transaction {
        address from;
        address to;
        uint value;
        uint64 time;
    }
    Transaction[] public transactions;

    constructor (string _bankname) Bank(_bankname) public{
    }
    
    function registerUser(string username) {
        require(OwnerToUser[msg.sender].ownerUser == 0x0, "Address da co tai khoan");
        User memory user = User(username, 1000, msg.sender);
        users.push(user);
        uint id = users.push(user) -1;
        UserIdToOwner[id] = msg.sender;
        OwnerToUserId[msg.sender] = id;
        OwnerToUser[msg.sender] = user;
    }
    function getInfoUser() public view returns(string name, uint amount, address ownerUser) {
        User user = OwnerToUser[msg.sender];
        return (user.username, user.amount, user.ownerUser);
        
    }
    function guiTien(address nguoinhan, uint sotien) public{
        User user = OwnerToUser[msg.sender];
        user.amount = user.amount - sotien;
        User usernhan = OwnerToUser[nguoinhan];
        usernhan.amount = usernhan.amount + sotien;
        Transaction memory transaction = Transaction(msg.sender, nguoinhan, sotien, 1222);
        transactions.push(transaction);
        
    }
    function rutTien(uint sotien) {
        User user = OwnerToUser[msg.sender];
        user.amount = user.amount + sotien;
    }
    function transactionHistory() view returns(uint8[]) {
        uint8[] memory data = new uint8[](transactions.length);
        uint counter = 0;
        for(uint8 i = 0; i<transactions.length; i++){
            if(transactions[i].from==msg.sender || transactions[i].to==msg.sender){
                data[counter]=i;
                counter++;
            }
        }
        return data;
    }
    event guiTienThanhCong();
    event rutTienThanhCong();
}
pragma solidity ^0.4.25;

contract Bank1 {
    string public bankName;
    uint public totalMoney;
    address owner;
    
    constructor(string _bankName) public {
        bankName = _bankName;
        totalMoney = 1000;
        owner = msg.sender;
    }
    
    function ChangeNameBank(string _bankName) public {
        require(msg.sender == owner);
        bankName = _bankName;
    }
    
}

interface Bank1interface  {
    function GuiTien(address _to, uint256 _money) external;
    function RutTien(uint256 _money) external;
}

contract Bank2 is Bank1, Bank1interface {
    
    struct Customer {
        string nameCustomer;
        uint totalMoneyCustomer;
        address ownerCustomer;
    }
    
    Customer[] customers;
    
    struct Transaction {
        address from;
        address to;
        uint value;
        uint64 timestamp;
    }
    
    Transaction[] transactions;
    
    mapping(address => uint) OwnerToUserId;
    mapping(address => Customer) OwnerToUser;
    mapping(uint => address) UserIdToOwner;
     
    constructor (string _bankName) Bank1(_bankName) public {
    }
    
    event EvGuiTienThanhCong(address form, address to, uint money);
    event EvRutTienThanhCong(address form, uint money);
    
    modifier checkAcc() {
        require(OwnerToUser[msg.sender].ownerCustomer!=0x0,
        "chua co tai khoan");
        _;
    }
    

    modifier checkMoney(uint _money) {
        require(OwnerToUser[msg.sender].totalMoneyCustomer>=_money,
        "Không đủ tiền");
        _;
    }
    
    function DangKyTaiKhoan(string _nameUser) public{
        require(OwnerToUser[msg.sender].ownerCustomer==0x0, "chua co tai khoan");
        uint moneyUs = 0;
        Customer memory customer = Customer(_nameUser, moneyUs, msg.sender);
        uint id = customers.push(customer) - 1;
        UserIdToOwner[id] = msg.sender;
        OwnerToUserId[msg.sender] = id;
        OwnerToUser[msg.sender] = customer;
        totalMoney +=moneyUs;
    }
    function GetInfo() public view checkAcc() returns (string, uint){
        Customer memory customer = OwnerToUser[msg.sender];
        return (customer.nameCustomer, customer.totalMoneyCustomer);
    }
    
    function GetTransactionHistorys() public view returns (uint8[]){
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
    
    function GuiTien(address _to, uint256 _money) public checkAcc() checkMoney(_money){
        OwnerToUser[_to].totalMoneyCustomer += _money;
        OwnerToUser[msg.sender].totalMoneyCustomer -= _money;
        transactions.push(Transaction(msg.sender, _to, _money, uint64 (now)));
        emit EvGuiTienThanhCong(msg.sender, _to, _money);
    }
    
   
    function RutTien(uint256 _money) public checkMoney(_money){
        OwnerToUser[msg.sender].totalMoneyCustomer -= _money;
        transactions.push(Transaction(msg.sender, 0, _money, uint64 (now)));
        totalMoney -= _money;
        emit EvRutTienThanhCong(msg.sender, _money);
    }
    
}

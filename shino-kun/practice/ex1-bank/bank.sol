pragma solidity ^0.4.23;

contract Banks {
    string public bankName;
    uint public money;
    address public owner;
    uint public defaultMoney;

    struct Bank {
        string customer;
        uint money;
        uint id;
    }
    struct TransactionsDict {
        address from;
        address to;
        uint value;
        uint time;
    }
    mapping (uint => TransactionsDict) transactions;
    mapping (address => Bank) banks;
    address[] listCustomers;

    // check owner
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    // - Tạo contructor Bank , 
	// + khởi tạo gồm 3 tham số trên, mặc định số tiền của ngân hàng = 1000
    constructor (){
        money = 1000;
        defaultMoney = 50000;
        bankName = "Ngan hang ShinoBank";
        owner = msg.sender;
    }

    event Deposit (address id, uint money, uint time);
    event WithDraw (address id, uint money, uint time);

    // + tao 1 function đổi tên ngân hàng , trong đó chỉ chủ sở hữu ngân hàng mới có thể thay đổi
    function renameBank(string _bankName) onlyOwner public  {
        bankName = _bankName;
    }

    // + Lấy ra thông tin của ngân hàng, ai cũng có thể xem thông tin 
    function bankInformation() public returns(string, address){
        return (bankName, owner);
    }

    // - Tạo 1 interface gồm các function
	// + Gửi Tiền
	// + Rút Tiền

    function deposit(address _address, uint _money) public returns (string, uint){
        Bank storage bank = banks[_address];
        uint amount = bank.money + _money;
        bank.money = amount;
        emit Deposit (_address, _money, now);
        return ("Gửi tiền thành công. Số dư của bạn là: ", bank.money);
        
    }

    // check money
    // modifier hasBank(address _address){
    //     var bank = banks[_address];
    //     require(bank.money > defaultMoney);
    //     _;
    // }

    // function withDraw(address _address, uint _money) hasBank(address _address) public {
    //     var bank = banks[_address];
    //     bank.money -= _money;
    // }
    function withDraw(address _address, uint _money)  public returns(string, uint) {
        Bank storage bank = banks[_address];
        uint amount = bank.money - _money;
        emit WithDraw (_address, _money, now);

        if (amount < defaultMoney) {
            return ("Số dư không đủ", bank.money);
        }else if ((_money % defaultMoney) == 0) { // not working
            return ("Số tiền rút phải là bội của 50000", bank.money);
        }else {
            bank.money -= _money;
            return (bank.customer, bank.money);
        }

        
        
    }
}

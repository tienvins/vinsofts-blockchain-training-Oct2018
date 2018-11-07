pragma solidity ^0.4.25;
import "./bank.sol";

contract Transactions is Banks { 
	// + Lưu lịch sử giao dịch vào con tract gồm các thông tin + from  
	// 							+ to, 
	// 							+ value
	// 							+ time
    
    // - Tạo contract Bank2 thừa kế Bank1, interface phía trên
	// + tao một chức năng đăng ký tài khoản cho người dùng	
	// 	+ Gồm :  +tên
	// 		 +id
	// 		 +số dư (default = 0)
	// + lưu thông tin người dùng vào contract 
    function openBank(address _address, string _customer) public returns(string, address, string, uint){
        var bank = banks[_address];
        bank.customer = _customer;
        bank.money = defaultMoney;
        bank.id = _address;
        listCustomers.push(_address);
        return ("Bạn đã mở tài khoản thành công. ", bank.id, bank.customer, bank.money);
    }

    // + Tạo 1 chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
    function myBank (address _address) public returns (string, string, uint, address){
        var bank = banks[_address];
        return ("Số dư tài khoản của bạn là: ", bank.customer, bank.money, bank.id);
    }

    // + implement chức năng gửi tiền cho 1 tài khoản khác,  ( tạo event khi gửi thành công)
    // + implement rút tiền Tổng số tiền của ngân hàng sẽ bị trừ theo (tạo event khi rút tiền thành công )
    function sendMoney(address from, address to, uint money) public returns (string){
        var fromBank = banks[from];
        var toBank = banks[to];
        // toBank.money += money; not working
        uint fromAmount = fromBank.money - money;
        uint toAmount = toBank.money + money;
        if (fromAmount < defaultMoney){
            return "số dư không đủ";
        }else {
            fromBank.money = fromAmount;
            toBank.money = toAmount;
            transactionHistory(from, to);
            return "Gửi tiền thành công.";
        }
        
    }

    
    function transactionHistory(address from, address to) public {
        var transaction = transactions[now];
        transaction.from = from;
        transaction.to = to;
        transaction.value = msg.value;
        transaction.time = now;
    }

    // + lấy ra danh sách khách hàng, chỉ owner mới được lấy ra
    function getListCustomer() onlyOwner returns (address[]){
        return listCustomers;
    }
}
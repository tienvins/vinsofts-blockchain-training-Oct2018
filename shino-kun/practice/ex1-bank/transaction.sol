pragma solidity ^0.4.23;
import "./banks.sol";

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
    function openBank(address _address, string _customer) public returns(uint) {
        uint id = listCustomers.push(_address) - 1;
        banks[_address]= Bank(_customer, defaultMoney, id);
        return id;
        
    }

    // + Tạo 1 chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
    function myBank (address _address) public view returns (string, uint, uint){
        Bank memory bank = banks[_address];
        return (bank.customer, bank.money, bank.id);
    }

    // + implement chức năng gửi tiền cho 1 tài khoản khác,  ( tạo event khi gửi thành công)
    // + implement rút tiền Tổng số tiền của ngân hàng sẽ bị trừ theo (tạo event khi rút tiền thành công )
    function sendMoney(address from, address to, uint money) public returns (string){
        Bank storage fromBank = banks[from];
        Bank storage toBank = banks[to];
        // toBank.money += money; not working
        uint fromAmount = fromBank.money - money;
        uint toAmount = toBank.money + money;
        if (fromAmount < defaultMoney){
            return "số dư không đủ";
        }else {
            fromBank.money = fromAmount;
            toBank.money = toAmount;
            transactionHistory(from, to, money);
            return "Gửi tiền thành công.";
        }
        
    }
    //0x655a51174c21888b13768b0927a35ba5a75201da

    
    function transactionHistory(address from, address to, uint _value) public {
        TransactionsDict storage transaction = transactions[now];
        transaction.from = from;
        transaction.to = to;
        transaction.value = _value;
        transaction.time = now;
    }

    // + lấy ra danh sách khách hàng, chỉ owner mới được lấy ra
    function getListCustomer() public view returns (address[]){
        return listCustomers;
    }
}
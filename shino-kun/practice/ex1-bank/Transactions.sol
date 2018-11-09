pragma solidity ^0.4.23;
import "./Banks.sol";

contract Transactions is Banks { 
    // mở tài khoản
    function openBank(address _address, string _customer) public returns(uint) {
        require(!opened(_address));
        uint id = listCustomers.push(_address) - 1;
        banks[_address]= Bank(_customer, defaultMoney, id);
        return id;
        
    }
    
    // Check tài khoản đã tồn tại
    function opened(address _address) public returns(bool isIneed){
        if(listCustomers.length == 0) return false;
        return (listCustomers[banks[_address].id]  == _address);
    }

    // + Tạo 1 chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
    function myBank (address _address) public view returns (string, uint, uint){
        Bank memory bank = banks[_address];
        return (bank.customer, bank.money, bank.id);
    }

    // + implement chức năng gửi tiền cho 1 tài khoản khác,  ( tạo event khi gửi thành công)
    // + implement rút tiền Tổng số tiền của ngân hàng sẽ bị trừ theo (tạo event khi rút tiền thành công )
    function sendMoney(address from, address to, uint money) public returns (string){
        require(opened(from));
        require(opened(to));
        Bank memory fromBank = banks[from];
        Bank memory toBank = banks[to];
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
    
    // lưu lịch sử giao dịch
    function transactionHistory(address from, address to, uint _value) public {
        TransactionsDict memory transaction = transactions[now];
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
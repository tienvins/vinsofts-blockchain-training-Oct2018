pragma solidity ^0.4.23;
contract Bett{
    address public con = this; 
    struct infor{
        string name;
        address adres;
        uint number;
        uint money;
    }
    infor[] public listPeople;
    infor[] public listPeoplee;
    mapping(address => uint) balances;
    uint nonce;
        modifier check(infor[] list){
        require(list.length == 3);
        _;
        
    }
    // random tu 0 -> 2
    function random() internal returns (uint) {
        uint random = uint(keccak256(now, msg.sender, nonce)) % 3;
        nonce++;
        return random;
    }
    function betting(string _name, uint _number) public payable {
        require(msg.sender.balance > msg.value);
        require(_number < 3,"số dự đoán phải từ 0 -> 2");
        listPeople.push(infor(_name,msg.sender,_number,msg.value));
    }
    function run() check(listPeople)  public payable returns(string _nameWin, address _adresWin){
        uint result = random();
        address win;
        for(uint i = 0; i <listPeople.length; i++){
            if(listPeople[i].number == result){
                 win = listPeople[i].adres;
                _nameWin = listPeople[i].name;
                _adresWin= listPeople[i].adres;
                listPeople[i].adres.transfer(con.balance);  // chuyen tien tu contract den acount
            }
        }
        listPeople = listPeoplee;
    }
    function get() public returns(uint a){
        a =  listPeople.length;
    }
}

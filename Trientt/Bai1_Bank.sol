pragma solidity ^0.4.23;
pragma  experimental ABIEncoderV2;

contract Bank{
    address adBank;
    string private name;
    uint private money;
    string private owner;
    function setName(string _name)public{ // modifier 
        name = _name;
    }
    function getName() public view returns(string){
        return name;
    }
    function setMoney(uint _count)public{
        money = _count;
    }
    function getMoney() public view returns(uint){
        return money;
    }
    function setOwner(string _owner)public{
        owner = _owner;
    }
    function getOwner() public view returns(string){
        return owner;
    }
    constructor (string _name, string _owner) public{
        name = _name;
        money = 100000;
        owner = _owner;
        adBank = msg.sender;
    }
    modifier checkName(address _name){
        require(_name == adBank,"ban ko phai chu nhan bank");
        _;
    }
    function editName(string _name, address adres) checkName(adres) public{
        setName(_name);
        
    }
    function getInfor() public view returns(string _name,string _owner,uint _count) {
        _name = getName();
        _owner = getOwner();
        _count = getMoney();
    }

    
}
interface func{
    function send(address _to) public payable returns (bool);
    function receive() public payable returns (bool);
}

contract Bank2 is Bank,func{
    struct history{
        string state;
        address _from;
        address to;
        uint value;
        uint time;
    }
    constructor(string _bankName, string _name) Bank(_bankName, _name) public {}
    struct user{
        string nameUser;
        address idUser;
        uint balances;        
    }
    user[] public listUser;
    history[] public listHis;
    //chức năng đăng ký
    function singIn(string name) public{
        listUser.push(user(name,msg.sender,msg.sender.balance));
    }
    //chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
    function getInforUser() public view returns(user){
        for(uint i=0; i< listUser.length; i ++){
            if(listUser[i].idUser == msg.sender){
                return listUser[i];
            }
        }
    }
    //chức năng lấy danh sách khách hàng
    function getListUser() public view returns(user){
        for(uint i=0; i< listUser.length; i ++){
                return listUser[i];
            }
    }
    //chức năng gửi tiền cho 1 tài khoản khác and  save history
    function send(address _to) public payable returns (bool){
        if(msg.sender.balance > msg.value){
            _to.transfer(msg.value);
            listHis.push(history("send money",msg.sender,_to,msg.value,now)); // save history
            return true;
        }
        else return false;
        
    }
    //rút tiền  and  save history
    function receive() public payable returns (bool){
        if(msg.sender.balance > msg.value){
           setMoney(getMoney() - msg.value);
           listHis.push(history("receive money",msg.sender,address(0),msg.value,now)); // save history
            return true;
        }
        else return false;
    }
    function getHis(address ad) public view returns(history){
        for(uint i = 0 ; i < listHis.length; i++){
            if(listHis[i]._from == ad){
                return listHis[i];
            }
        }
    }
    
    
    
}


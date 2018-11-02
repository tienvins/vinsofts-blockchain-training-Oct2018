pragma solidity ^0.4.23;
pragma  experimental ABIEncoderV2;
contract Bank{
    string  name;
    uint  money;
    address  owner;

    constructor (string _name) public{
        name = _name;
        money = 100000;
        owner = msg.sender;
    }
    modifier checkName(){
        require(msg.sender == owner,"ban ko phai chu nhan bank");
        _;
    }
    function editName(string _name) checkName() public{
        name = _name;
    }
    function getInfor() public view returns(string _name,address _owner,uint _money) {
        _name = name;
        _owner = owner;
        _money = money;
    }
    
}
interface func{
    function sendTo(address _to, uint _amount) public  returns (bool);
    function receive(uint _amount) public  returns (bool);
}

contract Bank2 is Bank,func{
    struct history{
        string status;
        address _from;
        address to;
        uint value;
        uint time;
    }
    constructor(string _bankName) Bank(_bankName) public {}
    struct user{
        string nameUser;
        address idUser;
        uint  balancs;        
    }
    user[]  listUser;
    history[]  listHis;
    //chức năng đăng ký
    mapping (address => uint) checkExit; //check aaddress đã đăng ký chưa
    mapping(address => uint)  _addToIndex; //đánh chỉ mục cho mảng listUser
    mapping(address => history[]) listHisByAdres; // lấy ra list his theo address
    uint indexx = 0;
    function singIn(string name, uint _balancs) public{
        require(msg.sender != owner);
        require(checkExit[msg.sender] == 0);  // tài khoản phải chưa đc đăng ký
        user memory u = user(name,msg.sender,_balancs);
        listUser.push(u);
        checkExit[msg.sender] = 1; // check da dang ky
        _addToIndex[msg.sender] = indexx;
        indexx ++;
    }
    //chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
    function getInforUser() public view returns(user){
        require(checkExit[msg.sender] !=0);   // chỉ khi đăng ký ms chuyển đc tiền
        require(msg.sender != owner);
        return listUser[_addToIndex[msg.sender]];
    }
    //chức năng lấy danh sách khách hàng
    function getListUser() checkName() public view returns(user[]){
        return listUser;
    }
    //chức năng gửi tiền cho 1 tài khoản khác and  save history
    event sended(address _from, address _to,uint _money);
    function sendTo(address _to, uint _amount) public returns (bool){
         require(checkExit[msg.sender] !=0);   // chỉ khi đăng ký ms chuyển đc tiền
         require(listUser[_addToIndex[msg.sender]].balancs > _amount );
         require(_amount > 0);
         require(msg.sender != owner);
         listUser[_addToIndex[msg.sender]].balancs -=_amount;  // trừ tiền trong list user để get ra user luôn chính 
         listUser[_addToIndex[_to]].balancs +=_amount;
         //listHis.push(history("send money",msg.sender,_to,_amount,now)); // save history
         listHisByAdres[msg.sender].push(history("send money",msg.sender,_to,_amount,now)); //thêm  vào listHisByAdres theo adress
         listHisByAdres[_to].push(history("receive money",msg.sender,_to,_amount,now)); //thêm  vào listHisByAdres theo adress
         emit sended(msg.sender,_to,_amount);
        return true;
    }
    //rút tiền  and  save history
    event received(address _from,uint _money);
    function receive(uint _amount) public  returns (bool){
        require(checkExit[msg.sender] !=0);   // chỉ khi đăng ký ms chuyển đc tiền
        require(msg.sender != owner);
        require(listUser[_addToIndex[msg.sender]].balancs > _amount );
        require(_amount > 0);
        listUser[_addToIndex[msg.sender]].balancs -=_amount;
        //listHis.push(history("receive money",msg.sender,address(0),_amount,now)); // save history
        listHisByAdres[msg.sender].push(history("receive money",msg.sender,address(0),_amount,now));
        emit received(msg.sender,_amount);
        return true;
    }
    function getHis() public view returns(history[]){
        require(msg.sender != owner);
        require(checkExit[msg.sender] !=0);
        return listHisByAdres[msg.sender];
        
    }
    
    
    
}

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
    mapping (address => uint) checkExit;
    mapping(address => uint)  _addToIndex;
    uint indexx = 0;
    function singIn(string name, uint _balancs) public{
        require(msg.sender != owner);
        require(checkExit[msg.sender] == 0);  // tài khoản phải chưa đc đăng ký
        user memory u = user(name,msg.sender,_balancs);
        listUser.push(u);
        checkExit[msg.sender] = 1; // check da dang ky
        //_userMap[msg.sender] = u;
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
    function sendTo(address _to, uint _amount) public returns (bool){
         require(checkExit[msg.sender] !=0);   // chỉ khi đăng ký ms chuyển đc tiền
         require(listUser[_addToIndex[msg.sender]].balancs > _amount );
         require(_amount > 0);
         require(msg.sender != owner);
         listUser[_addToIndex[msg.sender]].balancs -=_amount;  // trừ tiền trong list user để get ra user luôn chính 
         listUser[_addToIndex[_to]].balancs +=_amount;
         listHis.push(history("send money",msg.sender,_to,_amount,now)); // save history
        return true;
    }
    //rút tiền  and  save history
    function receive(uint _amount) public  returns (bool){
        require(checkExit[msg.sender] !=0);   // chỉ khi đăng ký ms chuyển đc tiền
        require(msg.sender != owner);
        require(listUser[_addToIndex[msg.sender]].balancs > _amount );
        require(_amount > 0);
        listUser[_addToIndex[msg.sender]].balancs -=_amount;
        listHis.push(history("receive money",msg.sender,address(0),_amount,now)); // save history
        return true;
    }
    function getHis() public view returns(history[]){
        require(msg.sender != owner);
        require(checkExit[msg.sender] !=0);
         history[] memory lisH = new history[](listHis.length);
         uint j = 0;
        if(listHis.length > 0){
        for(uint i = 0 ; i < listHis.length; i++){
            if(listHis[i]._from == msg.sender){
                lisH[j] = listHis[i];
                j++;
            }
        }
        return lisH;
        }
        
    }
    
    
    
}


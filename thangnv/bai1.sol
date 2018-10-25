pragma solidity ^0.4.25;

contract Bank{

    string name;
    uint totalMoney;
    address owner;

    constructor(string _name) {
        name=_name;
        totalMoney=1000;
        owner=msg.sender;
    }

    function changeName(string _name ) {
        require(owner==msg.sender,"Bạn không phải chủ ngân hàng");
        name=_name;
    }

    function getInfo() public returns(string,address,uint){
       return(name,owner,totalMoney);
    }
}

interface Action{
    function sendMoney(address _toonwer, uint _money) returns(address, address,uint,uint,uint);
    function rut_tien(uint _money) returns(address, uint, uint, uint );
}

contract Bank2 is  Bank, Action {

    mapping(address => Onwer) ownerToUser;

    struct Onwer{
        string name;
        address id;
        uint money;
    }

    Onwer[] onwers;

    struct History{
        address  from;
	    address  to;
	    uint  money;
	    uint  time;
    }

    History[] historys;


    constructor(string n) Bank (n){
    }

    function register(string _name) returns(string,address,uint){
        Onwer memory onwer = Onwer(_name, msg.sender,1000);
        onwers.push(onwer);
        ownerToUser[msg.sender]=onwer;
        totalMoney+=1000;
        return (onwer.name,onwer.id,onwer.money);
    }


    function getInfoOnwer() returns (string,address,uint){
        Onwer memory onwer = ownerToUser[msg.sender];
        return (onwer.name,onwer.id,onwer.money);
    }

    modifier checkAcc(address onwer) {
        require(ownerToUser[msg.sender].id==msg.sender,"Không có tài khoản");
        _;
    }

    modifier checkTotalMoney(uint _money) {
        require(totalMoney>=_money,"Ngân hàng không đủ tiền");
        _;
    }

    modifier checkMoney(address onwer,uint _money) {
        require(ownerToUser[msg.sender].money>=_money,"Số dư không đủ");
        _;
    }

    event da_gui(address onwergui, address _toonwer,uint _money);

    function sendMoney(address _toonwer, uint _money) checkAcc(msg.sender) checkTotalMoney(_money) checkMoney(msg.sender,_money) returns(address, address,uint,uint,uint){
        ownerToUser[msg.sender].money-=_money;
        ownerToUser[_toonwer].money+=_money;
        emit da_gui(msg.sender, _toonwer, _money);
        historys.push(History(msg.sender,_toonwer,_money,now));
        return (ownerToUser[msg.sender].id,ownerToUser[_toonwer].id,_money,ownerToUser[_toonwer].money,now);
    }

    function rut_tien(uint _money) checkAcc(msg.sender) checkTotalMoney(_money) checkMoney(msg.sender,_money) returns(address, uint,uint,uint){
        ownerToUser[msg.sender].money-=_money;
        totalMoney-=_money;
        return (ownerToUser[msg.sender].id,_money,ownerToUser[msg.sender].money,now);
    }

    function getOnwers() returns(address[]){
        require(owner==msg.sender,"Bạn không phải chủ ngân hàng");
        address[] memory ds = new address[](onwers.length);
        for(uint i=0; i<onwers.length;i++){
            ds[i]=(onwers[i].id);
        }
        return ds;
    }

    function getHistoryOnwers() checkAcc(msg.sender) returns(uint){
        uint sum=0;
        for(uint i=0; i<historys.length;i++){
            if(historys[i].from==msg.sender){
                sum+=1;
            }
        }
        return sum;
    }

}

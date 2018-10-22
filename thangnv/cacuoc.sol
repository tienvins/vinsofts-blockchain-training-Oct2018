pragma solidity ^0.4.25;


contract CaCuoc{
    
    address onwer;
    uint totalMoney;
    
    constructor(){
        onwer = msg.sender;
        totalMoney=0;
    }
    
    struct Onwer{
        address id;
        uint money;
        uint number;
    }
    
    struct History{
        address id;
        uint addmoney;
        uint number;
        uint time;
    }
    
    Onwer[] Onwers;
    mapping(address => Onwer) ToOnwer;
    
    function getInfoCaCuoc() returns(uint,uint){
        return(totalMoney,Onwers.length);
    }
    
    History[] Historys;
    mapping(address => History) ToHistory;
    
    
    modifier checkAcc(address sender){
        require(ToOnwer[sender].id!=sender,"Bạn đã đăng kí");
        _;
    }
    
    function register(uint number) payable checkAcc(msg.sender) {
        Onwer memory onwer = Onwer(msg.sender, 0, number);
        Onwers.push(onwer);
        ToOnwer[msg.sender]=onwer;
        totalMoney+=msg.value;
    }
    
    function getInfoOnwer() returns(address,uint){
        return(ToOnwer[msg.sender].id, ToOnwer[msg.sender].money);
    }
    
    function run() returns(address){   
        uint number = (uint(keccak256(now)) % 5)+1;
        for(uint i=0; i<Onwers.length;i++){
            if(Onwers[i].number==number){
                Onwers[i].money+=totalMoney;
                ToOnwer[Onwers[i].id]=Onwers[i];
                History memory history= History(Onwers[i].id,totalMoney,Onwers[i].number,now);
                Historys.push(history);
                totalMoney=0;
                return Onwers[i].id;
            }
        }
    }
    
    function getMoneyOnwer(address onwer) returns(uint){
        uint money =0;
        for(uint i=0; i<Historys.length;i++){
            if(Historys[i].id==ToOnwer[onwer].id){
                money+=Historys[i].addmoney;
            }
        } 
        return money;
    }
}
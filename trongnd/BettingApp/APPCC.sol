pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;

contract Betting{
    
    address owner;
    uint numberOwner=3;
    
    struct Owner{
        address id;
        uint number;
        uint money;
    }
    
    constructor(){
        owner = msg.sender;
    }
    
    function changeNumberOwner(uint _numbeOwner) checkOwner(){
        numberOwner=_numbeOwner;
    }
    
    Owner[] Owners;
    Owner[] HisTOwners;
    mapping(address => Owner) ToOwner;
    
    struct History{
        uint time;
        address id;
        uint number;
        uint addmoney;
    }
    
    History[] Historys;
    mapping(address => History) ToHistory;
    
    function register(uint _number) public payable checkAcc() checkValue(_number) {
        
        uint rep=0;
        for(uint i=0; i<Owners.length;i++){
            if(Owners[i].number == _number){
                rep +=1;
            }
        }
        require(rep==0,"So nhap vao da co nguoi chon");
        Owner memory owner = Owner(msg.sender, _number, msg.value);
        Owners.push(owner);
        ToOwner[msg.sender]=owner;
        emit registered(msg.sender, _number);
        if(Owners.length==numberOwner){
            run();
        }
    }
    
    function getMoneyContract() view returns(uint){
        return(this.balance);
    }
    
    function getInfoBetting() view returns(uint,Owner[]){
        return(numberOwner,Owners);
    }
    
    function getHistory() view returns(History[]){
        return(Historys);
    }
    
    function run() internal{   
        uint number = (uint(keccak256(now)) % numberOwner)+2;
        for(uint i=0; i<Owners.length;i++){
            if(Owners[i].number==number){
                Owners[i].id.transfer((numberOwner-1)* Owners[i].money);
                History memory history= History(now,Owners[i].id,Owners[i].number,(numberOwner-1)* Owners[i].money);
                Historys.push(history);
            }
        }
        Owners=HisTOwners;
    }
    
    function kill() checkOwner() {
        selfdestruct(owner);
    }
    
    function checkrRegister(address _sender) internal returns(bool) {
        for(uint i=0;i<Owners.length;i++){
                if(Owners[i].id==_sender){
                    return false;
                }
            }
            return true;
    }
    
    modifier checkAcc(){
        require(checkrRegister(msg.sender),"ban da dang ky");
        _;
    }
    
    modifier checkOwner(){
        require(msg.sender==owner,"Ban k co quyen");
        _;
    }
    
    modifier checkValue(uint _number) {
        require(msg.value>=1 ether,"ban phai dat toi thieu 1 ether");
        msg.sender.transfer(msg.value- 1 ether);
        _;
    }
    
    event registered(address _owner, uint _number);
    
}

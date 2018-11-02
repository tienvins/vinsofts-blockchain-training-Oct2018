pragma solidity ^0.4.25;

pragma experimental ABIEncoderV2;
contract Betting{
    
    address owner;
    address _r = this;
    uint numberOwner=3;
    
    constructor(){
        owner = msg.sender;
    }
    
    struct Owner{
        address id;
        uint number;
        uint money;
    }
    
    Owner[] Owners;
    Owner[] EmtyOwners;
    mapping(address => Owner) ToOwner;
    
    struct History{
        uint time;
        address id;
        uint number;
        uint addmoney;
    }
    
    History[] Historys;
    mapping(address => History) ToHistory;
    
    function register(uint number) payable checkAcc(msg.sender) checkValue() {
        Owner memory owner = Owner(msg.sender, number, msg.value);
        Owners.push(owner);
        ToOwner[msg.sender]=owner;
        if(Owners.length==numberOwner){
            run();
        }
    }
    
    function getMoneyContract() view returns(uint){
        return(this.balance);
    }
    
    function getInfoBetting() view returns(Owner[]){
        return(Owners);
    }
    
    function getHistory() view returns(History[]){
        return(Historys);
    }
    
    function run() internal{   
        uint number = (uint(keccak256(now)) % numberOwner)+1;
        for(uint i=0; i<Owners.length;i++){
            if(Owners[i].number==number){
                
                Owners[i].id.transfer(2* Owners[i].money);

                History memory history= History(now,Owners[i].id,Owners[i].number,2* Owners[i].money);
                Historys.push(history);
                
                Owners=EmtyOwners;
            }
        }
    }
    
    function killContract() checkOwner() {
        selfdestruct(owner);
    }
    
    function check(address sender) internal returns(bool) {
        for(uint i=0;i<Owners.length;i++){
                if(Owners[i].id==sender){
                    return false;
                }
            }
            return true;
    }
    
    modifier checkAcc(address sender){
        require(check(sender),"Bạn đã đăng kí");
        _;
    }
    
    modifier checkOwner(){
        require(msg.sender==owner,"Bạn không có quyền");
        _;
    }
    
    modifier checkValue(){
        require(msg.value==1 ether,"Bạn phải đặt 1 ether");
        _;
    }
}
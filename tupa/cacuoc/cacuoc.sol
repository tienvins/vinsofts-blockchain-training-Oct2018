pragma solidity ^0.4.25;

contract CaCuoc {
    
    address owner;
    uint public totalMoney;
    uint totalPeople = 5;
    
    struct User{
        address addressOwner;
        uint amountOwner;
        uint numberOwner;
    }
    User[] users;
    
    mapping (address => User) toUser;
    
    constructor() {
        owner = msg.sender;
        totalMoney = 0;
    }
    
    modifier checkAcc(){
        require(toUser[msg.sender].addressOwner != 0, "Bạn chưa có tài khoản");
        _;
    }
    
    function dangKyAndChooseNumber(uint _numberOwner) public payable {
        require(toUser[msg.sender].addressOwner == 0, "Bạn đã có tài khoản");
        User memory user = User(msg.sender, 0, _numberOwner);
        users.push(user);
        toUser[msg.sender] = user;
        require(msg.value >= 1 ether,"Tối thiểu 1 ether");
        totalMoney += msg.value;
        if(users.length==totalPeople){
            random();   
        }
    }
    function infoUser() checkAcc() public view returns(uint, uint, address){
        User memory user = toUser[msg.sender];
        return (user.amountOwner,user.numberOwner, user.addressOwner);
    }

    function random() checkAcc() internal returns(address) {
        uint number = (uint(keccak256(now)) % totalPeople) + 1;
        for(uint i=0; i <= users.length; i++){
            if(users[i].numberOwner==number){
                users[i].amountOwner+=totalMoney;
                toUser[users[i].addressOwner]=users[i];
                totalMoney=0;
                return users[i].addressOwner;
            }
        }
    }
    
    function getInfoOnwer() public view returns(address,uint){
        return(toUser[msg.sender].addressOwner, toUser[msg.sender].amountOwner);
    }
}
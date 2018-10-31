pragma solidity ^0.4.25;
contract CC{
    address owner = this;
    uint totalPeople = 3;
    struct User{    
        uint number;
        address addres;
    }
    User[] users;
    
    modifier checkBalance(){
        require(msg.sender.balance > msg.value, "Bạn ko đủ tiền để cược");
        _;
    }
    modifier checkNumber(uint _number){
        require(_number < totalPeople,"Số đc chon từ 1->10");
        _;
    }
    function chooseNumber(uint _number) checkBalance checkNumber(_number) public payable returns(address _addressWin){
        users.push(User(_number,msg.sender));
        if(users.length == totalPeople){
            return random();
        }
    }
    function random() private view returns(address _addressWin){
        uint random = uint(keccak256(now)) % totalPeople;
        for(uint i=0; i<users.length;i++){
            if(users[i].number == random){
                _addressWin = users[i].addres;
                users[i].addres.transfer(owner.balance);
            }
        }
    }
}
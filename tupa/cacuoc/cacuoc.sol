pragma solidity ^0.4.25;
contract CC{
    address owner = this;
    uint totalPeople = 3;
    uint ethBet = 1 ether;
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
        require(_number <= totalPeople && _number > 0,"Số đc chon từ 1->3");
        _;
    }
    
    function chooseNumber(uint _number) checkBalance checkNumber(_number) public payable returns(address _addressWin){
        if(msg.value > ethBet){
            msg.sender.transfer(msg.value - ethBet);
        }
        users.push(User(_number,msg.sender));
        if(users.length == totalPeople){
            return random();
        }
    }
    
    function random() private returns(address _addressWin){
        uint random = uint(keccak256(now)) % totalPeople + 1;
        for(uint i=0; i<users.length;i++){
            if(users[i].number == random){
                _addressWin = users[i].addres;
                _addressWin.transfer(owner.balance);
            }
        }
    }
}
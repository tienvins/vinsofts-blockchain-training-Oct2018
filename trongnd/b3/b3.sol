pragma solidity ^0.4.25;

contract CaCuoc{
    
    uint public amount = 0 ether;
  
  
    uint quay = 3;
    struct Customer{
        uint vis;
        address owner;
    }
    struct ownerToNumber{
        address owner;
    }
    Customer[] public customers;
    ownerToNumber[] ownertonumbers;
    ownerToNumber[] ownertonumbers2;
    uint[] numberS;
    
    mapping(address => uint) playerToNumber;
    mapping(uint => address[]) numberToPlayers;
    
    

    
    
    function DangKy() public{
        require(playerToNumber[msg.sender]==0x0,"Bạn đã đăng ký rồi");
        uint8 id = uint8(customers.push(Customer(0, msg.sender)));
        playerToNumber[msg.sender] = id;
    }
    function ChonSo(uint _number) public payable{
        require(playerToNumber[msg.sender]!=0x0,"Bạn phải đăng ký trước");
        bool oke = true;
        for (uint8 i = 0; i < ownertonumbers.length; i++){
            if(ownertonumbers[i].owner == msg.sender){
                oke = false;
            }
        }
        require(oke==true,"Vui lòng đợi đến khi trao thưởng");
        require(msg.value >= 1 ether,"Tối thiểu 1 ether");
        if(msg.value>1 ether){
            msg.sender.transfer(msg.value-1 ether);
        }
        // nhap nhieu hon 1 ether van se chi tru 1 ether 
        ownertonumbers.push(ownerToNumber(msg.sender));
        amount +=msg.value;
        numberToPlayers[_number].push(msg.sender);
        numberS.push(_number);
        if(ownertonumbers.length%quay==0){
            QuayThuong();
        }
    }
 
    function QuayThuong() private {
        uint random  =  (uint(keccak256(now)) % quay + 1);
        address[] memory  adr = numberToPlayers[random];
        if(adr.length>0){
            uint totalBet = amount/adr.length;
            for (uint8 i = 0; i< adr.length; i++){
                for (uint8 i2 = 0; i2 < customers.length; i2++){
                    if(customers[i2].owner == adr[i]){
                        customers[i2].vis +=totalBet;
                        customers[i2].owner.transfer(totalBet);
                    }
                }
            }
            for (uint8 i3 = 0; i3 < numberS.length; i3++){
                delete numberToPlayers[numberS[i3]];
            }
            amount = 0 ether;
            delete numberS;
            ownertonumbers = ownertonumbers2;
        }else{
            delete numberS;
            ownertonumbers = ownertonumbers2;
        }
    }
   
    
    
    
}

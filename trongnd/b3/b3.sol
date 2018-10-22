pragma solidity ^0.4.25;

contract CaCuoc{
    
    uint public amount = 0 ether;
    uint quay = 2;
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
    uint[] cacsodadcchon;
    
    mapping(address => uint) ownerToUserId;
    mapping(uint => address[]) numberToOwner;
    
    function DangKy() public{
        require(ownerToUserId[msg.sender]==0x0,"Bạn đã đăng ký rồi");
        uint8 id = uint8(customers.push(Customer(0, msg.sender)));
        ownerToUserId[msg.sender] = id;
    }
    function ChonSo(uint _number) public payable{
        require(ownerToUserId[msg.sender]!=0x0,"Bạn phải đăng ký trước");
        bool oke = true;
        for (uint8 i = 0; i < ownertonumbers.length; i++){
            if(ownertonumbers[i].owner == msg.sender){
                oke = false;
            }
        }
        require(oke==true,"Vui lòng đợi đến khi trao thưởng");
        require(msg.value >= 1 ether,"Tối thiểu 1 ether");
        ownertonumbers.push(ownerToNumber(msg.sender));
        amount +=msg.value;
        numberToOwner[_number].push(msg.sender);
        cacsodadcchon.push(_number);
        if(ownertonumbers.length%quay==0){
            TraoThuong();
        }
    }
    
    function TraoThuong() private {
        uint rand = 1;
        address[] adr = numberToOwner[rand];
        if(adr.length>0){
            uint tienthuong = amount/adr.length;
            for (uint8 i = 0; i< adr.length; i++){
                for (uint8 i2 = 0; i2 < customers.length; i2++){
                    if(customers[i2].owner == adr[i]){
                        customers[i2].vis +=tienthuong;
                    }
                }
            }
            for (uint8 i3 = 0; i3 < cacsodadcchon.length; i3++){
                delete numberToOwner[cacsodadcchon[i3]];
            }
            amount = 0 ether;
            delete cacsodadcchon;
            ownertonumbers = ownertonumbers2;
        }else{
            delete cacsodadcchon;
            ownertonumbers = ownertonumbers2;
        }
    }
}

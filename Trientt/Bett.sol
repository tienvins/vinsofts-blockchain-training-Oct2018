pragma solidity ^0.4.23;
contract Bett{
    address public owner;
    struct infor{
        address adres;
        uint number;
    }
    infor[] public listPeople;
    mapping(address => uint) public playerToNumber; //check mỗi ng chỉ đc đặt 1 lần
    mapping(uint => address[]) listWin;
    uint nonce;
    constructor() public{
        owner = msg.sender;
    }
    modifier check(uint _number){
        require(playerToNumber[msg.sender] == 0);  //check mỗi ng chỉ đc đặt 1 lần
        require(msg.value >= 1 ether);
        require(_number >0 && _number <11);
        _;
    }
    function random() internal returns (uint) {
        uint random = uint(keccak256(now, msg.sender, nonce)) % 10+1;
        nonce++;
        return random;
    }
    function betting(uint _number) check(_number)  public  payable{
        playerToNumber[msg.sender] = _number;   //check mỗi ng chỉ đc đặt 1 lần
        listWin[_number].push(msg.sender);  // list ng đặt cùng 1 số
        listPeople.push(infor(msg.sender,_number));
        run();
    }
    function run() internal{
        if(listPeople.length == 10){
        uint result = random();
        address[] memory lisAdresWin = listWin[result];
            if(lisAdresWin.length > 0){
                uint amountMoneyWin = this.balance/lisAdresWin.length;
                    for(uint i =0; i <lisAdresWin.length; i ++){
                        lisAdresWin[i].transfer(amountMoneyWin);
                    }
                listPeople.length = 0;
                }
            else {
                owner.transfer(this.balance);
                listPeople.length = 0;
            }
        }
    }
}

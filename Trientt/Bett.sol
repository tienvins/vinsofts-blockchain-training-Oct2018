pragma solidity ^0.4.23;
contract Bett{
    address public con = this;
    address public owner = msg.sender;
    struct infor{
        address adres;
        uint number;
    }
    infor[] public listPeople;
    infor[] public listPeoplee;
    mapping(uint => address[]) listWin;
    uint nonce;
    // random tu 0 -> 2
    function random() internal returns (uint) {
        uint random = uint(keccak256(now, msg.sender, nonce)) % 10;
        nonce++;
        return random;
    }
    function betting(uint _number)  public payable {
        require(msg.value >= 1 ether && msg.value > 0);
        require(msg.sender.balance > 0);
        require(msg.sender.balance > msg.value);
        require(_number >=0 && _number <10);
        listWin[_number].push(msg.sender);
        listPeople.push(infor(msg.sender,_number));
        run();
    }
    function run() public payable{
        if(listPeople.length == 3){
        uint result = random();
        address[] memory lisAdresWin = listWin[result];
            if(lisAdresWin.length > 0){
                uint amountMoneyWin = con.balance/lisAdresWin.length;
                    for(uint i =0; i <lisAdresWin.length; i ++){
                        lisAdresWin[i].transfer(amountMoneyWin);
                    }
                listPeople = listPeoplee;
                }
            else {
                owner.transfer(con.balance);
            }
        }
    }
}

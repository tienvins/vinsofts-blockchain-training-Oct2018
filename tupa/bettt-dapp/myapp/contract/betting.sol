pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

contract Betting {
    address public owner;
    uint public totalPeople = 3;
    uint public ethBet = 1 ether;
    uint public totalAmount;
    uint public numberPeopleBet = 0;
    uint public winner;
    address[] public players;
    
    struct User{
        address adsss;
        uint numberrr;
        uint moneyyy;
    }
    User[] users;
    
    struct History{
        uint time;
        address ads;
        uint money;
        uint number;
    }
    History[] historys;
    
    mapping(uint => address[]) numberToPlayers;
    mapping(address => uint) playerToNumber;
    
    modifier check(uint _number){
        require(msg.sender.balance > msg.value,'Số dư của bạn ko đủ');
        require(0 < _number && _number <= totalPeople, 'Số đc chọn từ 1->10');
        require(playerToNumber[msg.sender] == 0, 'Bạn chỉ đc chọn một lần');
        _;
    }
    
    modifier checkOwner(){
        require(owner == msg.sender,'Bạn ko phải là chủ');
        _;
    }
    constructor(){
        owner = msg.sender;
    }
    
    function bet(uint _number) public payable check(_number){
        if(msg.value > ethBet){
            msg.sender.transfer(msg.value - ethBet);
        }
        playerToNumber[msg.sender] = _number;
        players.push(msg.sender);
        numberToPlayers[_number].push(msg.sender);
        //
        User memory user = User(msg.sender,_number,msg.value);
        users.push(user);
        //
        numberPeopleBet += 1;
        totalAmount += msg.value;
        if(numberPeopleBet == totalPeople){
            run();
        }
    }

    function run() internal {
        uint winnerNumber = random();
        address[] memory winners = numberToPlayers[winnerNumber];
        if(winners.length > 0){
            uint winnerEthBet = totalAmount / winners.length;
            for (uint i = 0; i < numberToPlayers[winnerNumber].length; i++) {
                winners[i].transfer(winnerEthBet);
                History memory history =  History(now,winners[i],winnerEthBet,winnerNumber);
                historys.push(history);
            }
            
        }
        winner = winnerNumber;
        reset();
    }
    
    function random() public view returns(uint) {
        return (uint(keccak256(now)) % totalPeople + 1);
    }
    
    function getHistory() public view returns(History[]){
        return historys;
    }
    
    function getInfoBetting() public view returns(User[]){
        return users;
    }

    function reset() internal {
        for (uint i=0; i <= totalPeople; i++){
            numberToPlayers[i].length = 0;
        }
        for (uint j=0; j < players.length; j++){
            playerToNumber[players[j]] = 0;
        }
        for(uint k=0; k <= totalPeople; k++){
            users.length = 0;
        }
        
        players.length = 0;
        totalAmount = 0;
        numberPeopleBet = 0;
    }
    
    function kill() checkOwner public {
        selfdestruct(owner);
    }

}
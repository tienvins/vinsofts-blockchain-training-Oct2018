pragma solidity ^0.4.25;

import "./VinToken.sol";

contract ICOToken is Token {
    
    uint saleToken1From = now;
    uint saleToken1To   = now + 15 seconds;
    
    uint saleToken2From = now + 30 seconds;
    uint saleToken2To   = now + 45 seconds;
    
    uint saleToken3From = now + 60 seconds;
    uint saleToken3To   = now + 75 seconds;
    
    uint maxCoinIco           = 30000;  //tong coin ico;
    
    uint public maxTokenSale1 = 5000;   //pre-ico lan 1
    uint public buyToken1     = 0;
    uint public totalEth1     = 0;
    
    uint public maxTokenSale2 = 10000;  //pre-ico lan 2
    uint public buyToken2     = 0;
    uint public totalEth2     = 0;
    
    uint public maxTokenSale3 = 15000;  //pre-ico lan 3
    uint public buyToken3     = 0;
    uint public totalEth3     = 0;
    
    uint public price1         = 0.01 ether;    //gia ico lan 1
    uint public price2         = 0.05 ether;    //gia ico lan 2
    uint public price3         = 0.1 ether;     //gia ico lan 3
    address toOwner;    //dia chi nguoi tao
    
    constructor(){
        toOwner = msg.sender;
    }
    
    modifier checkTime(){
        require(getCurrentICOPhase()!=0,"Không trong thời gian mở bán");
        _;
    }
    
    modifier checkSoldToken(){
        require(getCurrentICOPhase()==1 && msg.value/price1 <= maxTokenSale1-buyToken1
                || getCurrentICOPhase()==2 && msg.value/price2 <= maxTokenSale2-buyToken2
                || getCurrentICOPhase()==3 && msg.value/price3 <= maxTokenSale3-buyToken3
                ,"Token đã bán hết");
        _;
    }
    
    function buyToken() checkTime checkSoldToken payable returns(bool) {
        if(getCurrentICOPhase()==1){
            uint token = msg.value/price1;
            toOwner.transfer(msg.value);
            toUser[toOwner].amount -=  token;
            toUser[msg.sender].amount += token;
            getNumberToken(token,msg.value);
            return true;
        }else if (getCurrentICOPhase() == 2){
            uint token2 = msg.value/price2;
            toOwner.transfer(msg.value);
            toUser[toOwner].amount -=  token2;
            toUser[msg.sender].amount += token2;
            getNumberToken(token2,msg.value);
            return true;
        }else {
            uint token3 = msg.value/price3;
            toOwner.transfer(msg.value);
            toUser[toOwner].amount -=  token3;
            toUser[msg.sender].amount += token3;
            getNumberToken(token3,msg.value);
            return true;
        }
        
    }
    
    function getNumberToken(uint _token, uint _ether) private {
        if(getCurrentICOPhase() == 1){
            buyToken1 += _token;
            totalEth1 += _ether;
        }else if (getCurrentICOPhase() == 2){
            buyToken2 += _token;
            totalEth2 += _ether;
        }else {
            buyToken3 += _token;
            totalEth3 += _ether;
        }
    }
    
    function getCurrentICOPhase() public constant returns(uint){
        if(now >= saleToken1From && now <= saleToken1To){
            return 1;
        }else if(now >= saleToken2From && now <= saleToken2To){
            return 2;
        }else if(now >= saleToken3From && now <= saleToken3To){
            return 3;
        }
        return 0;
    }
    
    
}

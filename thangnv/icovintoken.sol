
pragma solidity ^0.4.25;

import "./vintoken.sol";

contract ICOVinTokenSale is VinToken{
    
    uint public timeFrom1 = now;
    uint public timeTo1 = now+ 1 days; //thời gian mở bán 1
    
    uint public timeFrom2 = now+7 days;
    uint public timeTo2 = now+ 8 days; //thời gian mở bán 2
    
    uint public timeFrom3 = now+14 days;
    uint public timeTo3 = now+ 15 days; //thời gian mở bán 3
    
    uint public timeFrom4 = now+21 days;
    uint public timeTo4 = now+ 22 days; //thời gian mở bán 4
    
    uint public maxToken1 =5000; //tổng số token có thể bán
    uint public buyToken1 =0;    //số token đã bán
    uint public totalEther1=0;
    
    uint public maxToken2 =10000; 
    uint public buyToken2 =0;  
    uint public totalEther2=0;
    
    uint public maxToken3 =15000; 
    uint public buyToken3 =0; 
    uint public totalEther3=0;
    
    uint public maxToken4 =20000; 
    uint public buyToken4 =0; 
    uint public totalEther4=0;
    
    address public tokenOnwer; //tài hoản tạo ICOVinTokenSale
    
    constructor() VinToken(){
        tokenOnwer=msg.sender;
    }
    
    function getStep() public view returns(uint){
        if(now>=timeFrom1 || now<=timeTo1)
            return 1;
        else if(now>=timeFrom2 || now<=timeTo2)
            return 2;
        else if(now>=timeFrom3 || now<=timeTo3)
            return 3;
        if(now>=timeFrom4 || now<=timeTo4)
            return 4;
        return 0;
    }
    
    function addBuy(uint tokens,uint ethers) internal {
        if(getStep()==1){
            buyToken1+=tokens;
            totalEther1+=ethers;
        } else if(getStep()==2){
            buyToken2+=tokens;
            totalEther3+=ethers;
        } else if(getStep()==3){
            buyToken3+=tokens;
            totalEther3+=ethers;
        } else{
            buyToken4+=tokens;
            totalEther4+=ethers;
        }
    }
    
    function buyVinToken() checkTime() checkEther() checkNumberTokenICO() payable returns(bool) {
        uint tokens= msg.value/price;
        tokenOnwer.transfer(msg.value);
        toOnwer[tokenOnwer].tokenOnwer-=tokens;
        toOnwer[msg.sender].tokenOnwer+=tokens;
        addBuy(tokens,msg.value/1 ether);
        return true;
    }
    
    function changePrice(uint priceNew) checkOnwer(){
        price=priceNew;
    }
    
    modifier checkTime(){
        require(getStep()!=0,"Không trong thời gian mở bán");
        _;
    }
    
    modifier checkNumberTokenICO() {
        require(getStep()==1&&msg.value/price<=maxToken1-buyToken1
                ||getStep()==2&&msg.value/price<=maxToken2-buyToken2
                ||getStep()==3&&msg.value/price<=maxToken3-buyToken3
                ||getStep()==4&&msg.value/price<=maxToken4-buyToken4
            );
            _;
    }
    
    modifier checkEther(){
         require(msg.value>=price);
         require(msg.value%price==0);
        _;
    }
    
    modifier checkOnwer(){
        require(msg.sender==tokenOnwer,"Bạn không phải chủ token");
        _;
    }
}
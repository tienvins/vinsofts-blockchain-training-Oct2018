
pragma solidity ^0.4.25;

import "./erc20.sol";

contract ICOVinTokenSale is VinToken{
    
    uint public timeFrom1;
    uint public timeTo1;        //thời gian mở bán 1
    uint public maxToken1;      //tổng số token có thể bán 1
    uint public buyToken1;      //số token đã bán 1
    uint public totalEther1;    // số ether đã nhận được 1
    
    uint public timeFrom2;
    uint public timeTo2;
    uint public maxToken2;
    uint public buyToken2;
    uint public totalEther2;
    
    uint public timeFrom3;
    uint public timeTo3;
    uint public maxToken3; 
    uint public buyToken3;
    uint public totalEther3;
    
    uint public timeFrom4;
    uint public timeTo4;
    uint public maxToken4;
    uint public buyToken4;
    uint public totalEther4;
    
    address public tokenOwner; //tài khoản tạo ICOVinTokenSale
    
    constructor() VinToken(){
        
        timeFrom1   =   now;
        timeTo1     =   now+ 1 days;
        maxToken1   =   totalToken*15/100; 
        buyToken1   =   0;    
        totalEther1 =   0;
        
        timeFrom2   =   now+7 days;
        timeTo2     =   now+ 8 days;
        maxToken2   =   totalToken*10/100; 
        buyToken2   =   0;  
        totalEther2 =   0;
        
        timeFrom3   =   now+14 days;
        timeTo3     =   now+ 15 days;
        maxToken3   =   totalToken*5/100; 
        buyToken3   =   0; 
        totalEther3 =   0;
        
        timeFrom4   =   now+21 days;
        timeTo4     =   now+ 22 days;
        maxToken4   =   totalToken*3/100; 
        buyToken4   =   0; 
        totalEther4 =   0;
        
        tokenOwner  =   msg.sender;

    }
    
    function getStep() public view returns(uint){
        
        if(now>=timeFrom1 && now<=timeTo1)
            return 1;
        else if(now>=timeFrom2 && now<=timeTo2)
            return 2;
        else if(now>=timeFrom3 && now<=timeTo3)
            return 3;
        if(now>=timeFrom4 && now<=timeTo4)
            return 4;
        else
            return 0;
            
    }
    
    function addBuy(uint tokens,uint ethers) internal {
        
        if(getStep()==1){
            
            buyToken1   +=  tokens;
            totalEther1 +=  ethers;
            
        } else if(getStep()==2){
            
            buyToken2   += tokens;
            totalEther3 +=   ethers;
            
        } else if(getStep()==3){
            
            buyToken3   +=  tokens;
            totalEther3 +=   ethers;
            
        } else{
            
            buyToken4   +=  tokens;
            totalEther4 +=  ethers;
            
        }
        
    }
    
    function buyVinToken() checkTime() checkEther() checkNumberTokenICO() payable returns(bool) {
        
        uint tokens= msg.value/price;
        tokenOwner.transfer(msg.value);
        toOwner[tokenOwner].tokenOwner-=tokens;
        toOwner[msg.sender].tokenOwner+=tokens;
        addBuy(tokens,msg.value/1 ether);
        return true;
        
    }
    
    function changePrice(uint priceNew) checkOwner(){
        
        price=priceNew;
        
    }
    
    modifier checkTime(){
        
        require(getStep()!=0,"Không trong thời gian mở bán");
        _;
        
    }
    
    modifier checkNumberTokenICO() {
        
        require(
            getStep()==1    &&  msg.value/price<=maxToken1-buyToken1
            ||getStep()==2  &&  msg.value/price<=maxToken2-buyToken2
            ||getStep()==3  &&  msg.value/price<=maxToken3-buyToken3
            ||getStep()==4  &&  msg.value/price<=maxToken4-buyToken4
            ,"Số token còn lại trông đợt mở bán không đủ"
        );
        _;
            
    }
    
    modifier checkEther(){
        
         require(msg.value>=price,"Số Ether phải lớn hơn hoặc bằng 1 finney");
         require(msg.value%price==0,"Số Ether phải là bội của 1 finney");
        _;
        
    }
    
    modifier checkOwner(){
        
        require(msg.sender==tokenOwner,"Bạn không phải chủ token");
        _;
        
    }
}
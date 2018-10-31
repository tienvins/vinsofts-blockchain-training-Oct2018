pragma solidity ^0.4.25;
import "./vin-token.sol";

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}


contract ICOTokenSale is ERC20Token{
    using SafeMath for uint256;
    
    address public tokenOnwer; //the address receive ether
    uint private price = 1; // gia ban token
    
    uint public tokenSale1;//max tokens for public-sale
    uint public tokenSale2;//max tokens for public-sale
    uint public tokenSale3;//max tokens for public-sale
    uint public tokenSale4;//max tokens for public-sale
    
    uint public phasePublicSale1_From = now;
    uint public phasePublicSale1_To = now + 3 days;
    uint public preSaleTokenSold1 = 0;  

    uint public phasePublicSale2_From = now + 4 days;
    uint public phasePublicSale2_To = now + 5 days;
    uint public preSaleTokenSold2 = 0;  

    uint public phasePublicSale3_From = now + 6 days;
    uint public phasePublicSale3_To = now + 7 days;
    uint public preSaleTokenSold3 = 0;  
    
    uint public phasePublicSale4_From = now;
    uint public phasePublicSale4_To = now + 1 days;
    uint public preSaleTokenSold4 = 0;  
    
    uint public preSaleTokenSold = 0; 
	  
	constructor(uint _initialSupply,string _nameCoin, string _symbol, uint _decimals) ERC20Token(_initialSupply, _nameCoin, _symbol, _decimals) public{
	    tokenOnwer = msg.sender;
	    tokenSale1 = 10000 * 10**decimals;
	    tokenSale2 = 20000 * 10**decimals;
	    tokenSale3 = 30000 * 10**decimals;
	    tokenSale4 = 40000 * 10**decimals;
	    totalSupply = tokenSale1 + tokenSale2 + tokenSale3 + tokenSale4;
	}
	
	struct Buyer {
        uint totalETH; // total eth of investor to buy token
        uint totalTokens; // total token of investor
    }
    
	mapping (address => Buyer) public buyers;
	
	function getSteep() public view returns(uint) {
		if(now<phasePublicSale1_To){
			if(now>=phasePublicSale1_From)
				return 1;
		} else if(now<phasePublicSale2_To){
			return 2;
		} else if(now<phasePublicSale3_To){
			return 3;
		} else if(now<phasePublicSale4_To){
			return 4;
		}
		return 0;
	}
	
	function ethtoToken(uint _value) returns(uint){
	    require(_value >= 1 ether,"Mua toi thieu la 1 ether");
	    _value = _value/10**18;
	    uint boughtTokens = _value.mul(getPrice1Token());
	    return boughtTokens;
	}
	
	function getPrice1Token() public view returns (uint){
	    uint icoSteep = getSteep(); 
	    uint price2 = 1;
	    if(icoSteep == 1){
	        price2 = price.mul(10);
	    }else if(icoSteep == 2){
	        price2 = price.mul(5);
	    }else if(icoSteep == 3){
	        price2 = price.mul(2);
	    }if(icoSteep == 4){
	        price2 = price.mul(1);
	    }
	    return price2;
	}
	
	function getNumberTokenConLai() public view returns (uint){
	    uint icoSteep = getSteep(); 
	    if(icoSteep == 1){
	        return (tokenSale1.sub(preSaleTokenSold1));
	    }else if(icoSteep == 2){
	        return (tokenSale2.sub(preSaleTokenSold2));
	    }else if(icoSteep == 3){
	        return (tokenSale3.sub(preSaleTokenSold3));
	    }else if(icoSteep == 4){
	        return (tokenSale4.sub(preSaleTokenSold4));
	    }
	}
	function buy() payable public returns(bool){
	    
	    uint ethReceive = msg.value/10**18; // get ether investor send
	    uint icoSteep = getSteep(); 
	    uint boughtTokens = ethtoToken(msg.value); // caculate token 
	    
	    if(icoSteep == 1){
	        require(preSaleTokenSold1.add(boughtTokens) <= tokenSale1,"khong duoc phep mua qua so luong token lan 1");
    	        buyers[msg.sender].totalETH = buyers[msg.sender].totalETH.add(ethReceive);
    		    buyers[msg.sender].totalTokens = buyers[msg.sender].totalTokens.add(boughtTokens);
    		    preSaleTokenSold1 = preSaleTokenSold1.add(boughtTokens);
    		    preSaleTokenSold = preSaleTokenSold.add(boughtTokens);
	    }else if(icoSteep == 2){
	        require(preSaleTokenSold2.add(boughtTokens) <= tokenSale2,"khong duoc phep mua qua so luong token lan 2");
    	        buyers[msg.sender].totalETH = buyers[msg.sender].totalETH.add(ethReceive);
    		    buyers[msg.sender].totalTokens = buyers[msg.sender].totalTokens.add(boughtTokens);
    		    preSaleTokenSold2 = preSaleTokenSold2.add(boughtTokens);
    		    preSaleTokenSold = preSaleTokenSold.add(boughtTokens);
	    }else if(icoSteep == 3){
	        require(preSaleTokenSold3.add(boughtTokens) <= tokenSale3,"khong duoc phep mua qua so luong token lan 3");
    	        buyers[msg.sender].totalETH = buyers[msg.sender].totalETH.add(ethReceive);
    		    buyers[msg.sender].totalTokens = buyers[msg.sender].totalTokens.add(boughtTokens);
    		    preSaleTokenSold3 = preSaleTokenSold3.add(boughtTokens);
    		    preSaleTokenSold = preSaleTokenSold.add(boughtTokens);
	    }else if(icoSteep == 4){
	        require(preSaleTokenSold4.add(boughtTokens) <= tokenSale4,"khong duoc phep mua qua so luong token lan 4");
    	        buyers[msg.sender].totalETH = buyers[msg.sender].totalETH.add(ethReceive);
    		    buyers[msg.sender].totalTokens = buyers[msg.sender].totalTokens.add(boughtTokens);
    		    preSaleTokenSold4 = preSaleTokenSold4.add(boughtTokens);
    		    preSaleTokenSold = preSaleTokenSold.add(boughtTokens);
	    }
	    tokenOnwer.transfer(msg.value);  // chu token nhan tien tu ng gui
	    return true;
	}
	
	function () public {
	    buy();
	}
}

pragma solidity ^0.4.25;

contract VinToken{
    
    string  public name;
    uint    public decimals;
    string  public symbol;
    uint    public price;
    uint    public totalToken;
    
    struct Owner{
        address id;
        uint tokenOwner;
    }        
    
    mapping(address=>Owner)toOwner;
    
    mapping(address => mapping(address => uint)) allowed;
    
    constructor(){  
        name        =   "VinToken";
        decimals    =   0;
        totalToken  =   1000000000;
        symbol      =   "Vin";
        price       =   0.001 ether;
        Owner memory owner  =   Owner(msg.sender,totalToken);
        toOwner[msg.sender] =   owner;
    }
    
    function totalSupply() public view returns(uint){
        return totalToken;
    }
    
    function balanceOf (address _owner) public returns (uint){
        return toOwner[_owner].tokenOwner;
    }
    
    function transfer(address to, uint tokens) public checkNumberToken(tokens) returns (bool) {
        
        toOwner[msg.sender].tokenOwner  -=  tokens;
        toOwner[to].tokenOwner          +=  tokens;
        return true;
        
    }
    
    function transferFrom(address _from, address _to, uint _value)public checkAllowance(_from,_value) returns (bool){
        
        toOwner[_from].tokenOwner   -=  _value;
        allowed[_from][msg.sender]  -=  _value;
        toOwner[_to].tokenOwner     +=  _value;
        return true;
        
    }
    
    function approve(address _spender, uint _value)public checkNumberToken(_value) returns (bool){
        
        allowed[msg.sender][_spender]   =   _value;
        return true;
        
    }
    
    function allowance (address _owner, address _spender)public returns (uint){
        
        return allowed[_owner][_spender];
        
    }
    
    
    modifier checkNumberToken(uint tokens){
        
        require(toOwner[msg.sender].tokenOwner>=tokens,"Số token của bạn nhỏ hơn số  bạn đang chọn ");
        _;
        
    }
    
    modifier checkAllowance(address _from,uint tokens){
        
        require(allowance(_from,msg.sender)>=tokens,"Số token được ủy quyền  cho bạn nhỏ hơn số  bạn đang chọn ");
        _;
        
    }
}
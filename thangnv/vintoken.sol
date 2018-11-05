pragma solidity ^0.4.25;

library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    require(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0);
    uint256 c = a / b;
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;
    return c;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);
    return c;
  }

  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}

contract Token {

    function totalSupply() constant returns (uint256 supply) {}

    function balanceOf(address _owner) constant returns (uint256 balance) {}

    function transfer(address _to, uint256 _value) returns (bool success) {}

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}

    function approve(address _spender, uint256 _value) returns (bool success) {}

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}
contract StandardToken is Token {
    
    using SafeMath for uint;
    
    uint256 public totalSupply;
    
    mapping(address=>uint)Owner;
    
    mapping(address => mapping(address => uint)) allowed;
    
    function balanceOf (address _owner) public view returns (uint){
        return Owner[_owner];
    }
    
    function transfer(address _to, uint _tokens) public checkNumberToken(_tokens) returns (bool) {
        Owner[msg.sender]= Owner[msg.sender].sub(_tokens);
        Owner[_to]= Owner[_to].add(_tokens);
        emit Transfer(msg.sender, _to, _tokens);
    }
    
    function transferFrom(address _from, address _to, uint _tokens)public checkAllowance(_from,_tokens) returns (bool){
        Owner[_from]= Owner[_from].sub(_tokens);
        allowed[_from][msg.sender]= allowed[_from][msg.sender].sub(_tokens);
        Owner[_to]= Owner[_to].add(_tokens);
        emit Transfer(_from, _to, _tokens);
    }
    
    function approve(address _spender, uint _tokens)public checkNumberToken(_tokens) returns (bool){
        allowed[msg.sender][_spender]   =   _tokens;
        emit Approval(msg.sender, _spender, _tokens);
    }
    
    function allowance (address _owner, address _spender)public view returns (uint){
        return allowed[_owner][_spender];
    }
    
    
    modifier checkNumberToken(uint _tokens){
        require(Owner[msg.sender]>=_tokens,"Số token của bạn nhỏ hơn số  bạn đang chọn ");
        _;
    }
    
    modifier checkAllowance(address _from,uint _tokens){
        require(Owner[_from]>=_tokens,"Số token của người ủy quyền  không  đủ");
        require(allowance(_from,msg.sender)>=_tokens,"Số token được ủy quyền  cho bạn nhỏ hơn số  bạn đang chọn ");
        _;
    }
}

contract VinToken is StandardToken {

    string  public name;
    uint    public decimals;
    string  public symbol;
    uint    public price;
    string public version;

    constructor() {
        name        =   "VinToken";
        decimals    =   18;
        totalSupply  =   1000000000;
        symbol      =   "Vin";
        price       =   0.001 ether;
        Owner[msg.sender] =   totalSupply;                           
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}
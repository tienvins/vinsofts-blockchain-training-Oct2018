pragma solidity ^0.4.4;

interface Token {
    function totalSupply() view returns (uint256 supply);
    function balanceOf(address _owner) view returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) view returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}
contract StandardToken is Token {
    uint256 public _totalSupply;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    //chức năng totalSupply: Hiển thị tổng cung cấp mã thông báo của bạn.
    function totalSupply() public view returns(uint256 supply){
        return _totalSupply;
    }
    // function balanceOf: Hiển thị số lượng token mà mỗi tài khoản có.
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
    //chức năng transfer: Gửi value(số lượng token đến địa chỉ (người nhận). Địa chỉ người gửi thường là msg.sender.
    function transfer(address _to, uint256 _value) public returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }
    //chức năng transferFrom: Cũng giống như chuyển giao, chỉ trong trường hợp này người dùng cần phải xác định địa chỉ người gửi 
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }
    //xác thực từ 1 acount  khác
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    // /chức năng allowance: Hiển thị số lượng token có thể được chi tiêu thay mặt cho chủ sở hữu mã token heo từng địa chỉ được chấp thuận
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

}

contract ERC20Token is StandardToken {

    function () public {
        revert();
    }
    string public name;                   
    uint8 public decimals;                
    string public symbol;                 
    string public version = 'H1.0'; 
    address public owner = msg.sender;
    
    constructor() public {
        balances[msg.sender] = 100000;               // người phát hành sẽ lắm giữ toàn bộ token
        _totalSupply = 100000;                        // Tong cung token
        name = "VinToken";                          // tên của token
        decimals = 3;                                // số chữ số thập phân  để hiển  thi
        symbol = "VIN";                              // ký kiệu đồng coin
    }
}

// ico token
contract IcoToken is ERC20Token{
    uint public price;          // gia 1 token
    uint public timeFrom;      //thoi gian bat dau 
    uint public timeTo;         // time kết thúc 
    uint public time;        //thời gian mở bán 1 đợt
    uint public maxToken1 ;      //tổng số token có thể bán 1
    uint public step = 0; //đợt ban
    uint public token; //so token hien tai dang dc mua
    uint public stepOld =0;
    //mở đợt bán
    function open(uint _step, uint _time, uint _price) public{
        if(_step - stepOld == 1){ // để quy trình theo từng bước
            stepOld += 1;
            timeFrom = now;
            step = _step;
            time = _time * 1 days;
            price = _price * 1 finney;
            timeTo = timeFrom + time;            
        }
        else revert();

            
    }
    function buyToken() public payable returns(bool){
        if(now< timeTo && step == 1){
            maxToken1 = _totalSupply *15/100;
            token = msg.value / price;  // số token mà khách hàng có thể mua khi có n value
            if(maxToken1>token && msg.sender.balance > msg.value){
                _totalSupply -= token;
                owner.transfer(msg.value);
                return true;
            }
            else {
                revert();
                return false;
            }
        }
        else if(step == 2 && now < timeTo){
                maxToken1 = _totalSupply *10/100;
                token = msg.value / price;
                if(maxToken1>token && msg.sender.balance > msg.value){
                    _totalSupply -= token;
                    owner.transfer(msg.value);
                    return true;
                }
                else {
                    revert();
                    return false;
            }
        }
        else if(step == 3 && now < timeTo){
                maxToken1 = _totalSupply *5/100;
                token = msg.value / price;
                if(maxToken1>token && msg.sender.balance > msg.value){
                    _totalSupply -= token;
                    owner.transfer(msg.value);
                    return true;
                }
                else{
                    revert();
                    return false;
            }
        }
        else if(step == 4 && now < timeTo){
                maxToken1 = _totalSupply *3/100;
                token = msg.value / price;
                if(maxToken1>token && msg.sender.balance > msg.value){
                    _totalSupply -= token;
                    owner.transfer(msg.value);
                    return true;
                }
                else {
                    revert();
                    return false;
            }
        }
        else revert();
    }
    // đóng đợt bán
    function close() public{
        step = 0;
    }
    
}

pragma solidity ^0.4.25;

contract MyToken {
    mapping (address => uint256) balanceOf;

    function MyToken(uint256 money) {
        balanceOf[msg.sender] = money;
    }

    function Transfer(address _to, uint256 _value) public constant returns (bool success){
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }
}
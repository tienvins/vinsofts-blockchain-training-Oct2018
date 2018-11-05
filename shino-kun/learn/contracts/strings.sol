pragma solidity ^0.4.25;
contract Strings {
    function concat(string b, string v) internal returns(string){
        bytes memory _b = bytes(b);
        bytes memory _v = bytes(v);

        string memory _tmp = new string(_v.length + _b.length);
        bytes memory _str = bytes(_tmp);
        uint i;
        uint j;

        for (i=0; i < _b.length; i++ ){
            _str[j++] = _b[i];
        }

        for (i=0; i < _v.length; i++ ){
            _str[j++] = _v[i];
        }

        return string(_str);
    }
}

contract Test is Strings{
    function test(string _b) returns(string){
        return concat(_b, "_shino");
    }
}
pragma solidity ^0.4.25;

library IntExtended {
    function increment (uint _self) returns (uint){
        return _self+1;
    }

    function decrement (uint _self) returns (uint){
        return _self-1;
    }

}

contract Test {
    using IntExtended for uint;

    function test(uint _base) returns (uint){
        return _base.increment();
    }
}
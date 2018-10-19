pragma solidity ^0.4.5;
import "./library.sol";

contract MyMemory {
    uint num1;
    uint num2;
    constructor (){
        num1 = 1;
        num2 = 2;
    }

    function myMemory(uint _u) returns (uint, uint) {
        uint memory num3 = num1;
        num3 += _u;
        return (num1, num3);
    }

    function myStorage(uint _u) returns (uint, uint) {
        uint storage num4 = num2;
        num4 += _u;
        return (num2, num4);
    }
}
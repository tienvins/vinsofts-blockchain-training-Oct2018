pragma solidity ^0.4.5;
import "./library.sol";

contract MyMemory {
    struct Number { uint num; }
    Number[] items;

    function myMemory(uint _u)  {
        Number memory item = Number(_u);
        items.push(item);
    }

    function myStorage(uint _index) returns (uint) {
        require(items.length > _index, "hihihi");
        Number storage item = items[_index];
       
        return (item.num);
    }
}
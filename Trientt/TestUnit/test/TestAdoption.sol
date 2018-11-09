pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TruyXuatTT.sol";

contract TestAdoption {
  TruyXuatTT access = TruyXuatTT(DeployedAddresses.TruyXuatTT());
    function testSetPeople() public {
        uint b = access.setPeople("Trien",23,"nam");
        uint a = 1;
        Assert.equal(a,b, "Owner of pet ID 8 should be recorded.");
    }
}
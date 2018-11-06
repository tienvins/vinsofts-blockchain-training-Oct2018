pragma solidity ^0.4.25;
import "./shino_token.sol";

contract Crowdsale is ShinoToken {

    uint256 defaultTime = 1541470751;
    uint timeRange = 12;
    struct Bonus{
        uint256 timeFrom;
        uint256 timeTo;
        uint256 bonus;
        uint256 money;

    }
    mapping (uint => Bonus) bonus;
    
    constructor () {
        for (uint i = 1; i <= 4; i++){

        }
    }

    function checkTime(uint timeFrom, uint timeTo) public returns (bool){
        if (now >= timeFrom && now <= timeTo){
            return true;
        }else {
            return false;
        }
    }
    
    
}
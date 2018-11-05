pragma solidity ^0.4.25;
contract MyEnum {
    enum ActionChoices { GoLeft, GoRight, GoTraight, SitStill}
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoTraight;

    function setGoTraight() public {
        choice = ActionChoices.GoRight;
    }
    
    function getChoice() view public returns(ActionChoices){
        return choice;
    }

    function getDefaultChoice() pure public returns(uint){
        return uint(defaultChoice);
    }

    function changeDirection(ActionChoices _choice) public  returns(string){
       if (_choice == ActionChoices.GoLeft) {
            //do some thing
           return "Please go right";
        } else if (_choice == ActionChoices.GoRight) {
            //do some thing
            return "Please go left";
        }else {
            return "Anywhere";
        }
    }
 
}
pragma solidity ^0.4.25;
contract MyEnum {
    enum ActionChoices { GoLeft, GoRight, GoTraight, SitStill}
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoTraight;

    function setGoTraight() public {
        choice = ActionChoices.GoTraight;
    }
    
    function getChoice() view public returns(ActionChoices){
        return choice;
    }

    function getDefaultChoice() pure public returns(uint){
        return uint(defaultChoice);
    }

}
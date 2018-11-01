pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;
contract file{
    struct personal{
        string name;
        uint age;
        string sex;
    }
    personal[] lisPeople;
    function setPeople(string _name, uint _age, string _sex, uint count) public{
        lisPeople.push(personal(_name,_age,_sex));
    }
    function getPeoplebyId(uint id) public view returns(string _name, uint _age, string _sex, uint count){
            _name = lisPeople[id].name;
            _sex = lisPeople[id].sex;
            _age = lisPeople[id].age;
    }
    function getAllPeople() public view returns(personal[]){
        return lisPeople;
    }
    
    
}

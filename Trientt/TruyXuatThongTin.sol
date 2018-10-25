pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;
contract HoSo{
    struct CaNhan{
        string name;
        uint age;
        string sex;
    }
    //mapping (uint => CaNhan) cn;
    CaNhan[] lisPeople;
    function setPeople(string _name, uint _age, string _sex, uint count) public{
        lisPeople.push(CaNhan(_name,_age,_sex));
    }
    function getPeoplebyId(uint id) public view returns(string _name, uint _age, string _sex, uint count){
            _name = lisPeople[id].name;
            _sex = lisPeople[id].sex;
            _age = lisPeople[id].age;
    }
    function getAllPeople() public view returns(CaNhan[]){
        return lisPeople;
    }
    
    
}

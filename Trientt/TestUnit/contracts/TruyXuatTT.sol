pragma solidity ^0.4.17;
pragma experimental ABIEncoderV2;
contract TruyXuatTT{
    struct personal{
        string name;
        uint age;
        string sex;
    }
    personal[] public lisPeople;
    function setPeople(string _name, uint _age, string _sex) public returns (uint){
        lisPeople.push(personal(_name,_age,_sex));
        return lisPeople.length;
    }
    function getPeoplebyId(uint id) public view returns(string _name, uint _age, string _sex){
            _name = lisPeople[id].name;
            _sex = lisPeople[id].sex;
            _age = lisPeople[id].age;
    }
    function getAllPeople() public view returns(personal[]){
        return lisPeople;
    }      
}
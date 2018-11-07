pragma solidity ^0.4.25;
contract Profiles {

    struct Users {
        string username;
        string firstname;
        string lastname;
        uint age;
        string gender;
    }

    mapping (address => Users) users;
    address[] public listUsers;

    function setProfile(address _address, string _username, string _firstname, string _lastname, uint _age, string _gender) public {
        var user = users[_address];
        user.username = _username;
        user.firstname = _firstname;
        user.lastname = _lastname;
        user.age = _age;
        user.gender = _gender;

        listUsers.push(_address);
    }

    function getProfile(address _address) public view  returns (string, string, string, uint, string){
        var user = users[_address];
        return (user.username, user.firstname, user.lastname, user.age, user.gender);
    }

    function getProfiles() public view  returns (address[]){
        return listUsers;
    }

    function countUsers() returns (uint){
        return listUsers.length;
    }


}
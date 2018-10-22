pragma solidity ^0.4.25;

contract UserCrud {
    struct UserStruct {
        bytes32 userEmail;
        uint userAge;
        uint index;
    }

    mapping (address => UserStruct) private userStructs;
    address[] private userIndex;

    event LogNewUser( 
        address indexed userAddress,
        uint index,
        bytes32 userEmail,
        uint userAge
    );

    event LogUpdateUser( 
        address indexed userAddress,
        uint index,
        bytes32 userEmail,
        uint userAge
    );


    function isUser(address userAddress) public constant returns (bool isIndeed){
        if (userIndex.length == 0) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }

    function insertUser(
        address userAddress,
        bytes32 userEmail,
        uint userAge
    ) public returns (uint index){
        if(isUser(userAddress)) throw;
        userStructs[userAddress].userEmail = userEmail;  
        userStructs[userAddress].userAge = userAge;  
        userStructs[userAddress].index = userIndex.push(userAddress) - 1;  
        
        emit LogNewUser(
            userAddress,
            userStructs[userAddress].index,
            userEmail,
            userAge
        );

        return userIndex.length - 1;
    }

    function getUser(address userAddress) public constant returns (bytes32 userEmail, uint userAge, uint index){
        if(!isUser(userAddress)) throw;
        return (
            userStructs[userAddress].userEmail,
            userStructs[userAddress].userAge,
            userStructs[userAddress].index
        );
    }

    function updateUserEmail(
        address userAddress, 
        bytes32 userEmail
    ) public constant returns (bool success){
        if(!isUser(userAddress)) throw;
        userStructs[userAddress].userEmail = userEmail;

        emit LogUpdateUser(
            userAddress,
            userStructs[userAddress].index,
            userEmail,
            userStructs[userAddress].userAge
        );
        return true;
    }

    function deleteUser(address userAddress) constant returns (bool success){
        uint rowToDelete = userStructs[userAddress].index;
        address keyToMove = userIndex[userIndex.length-1];
        userIndex[rowToDelete] = keyToMove;
        userStructs[keyToMove].index = rowToDelete;
        userIndex.length --;
        return true;
    }


    function getUserByIndex(uint _index) public returns (address){
        return userIndex[_index];
    }

    function getCountUsers() returns (uint){
        return userIndex.length;
    }

    function getListUserAddress() public constant returns (address[] list){
        return userIndex;
    }

}
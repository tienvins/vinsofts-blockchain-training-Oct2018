pragma solidity ^0.4.25;

contract Animals {
    struct Animal {
        bytes32 dna;
        string name;
        bool sex;
        uint age;
        uint weight;
        uint bornTime;
        bool status;
        uint coolDownTime;
        uint index;
        uint count;
    }

    mapping (address => Animal) animals;
    address[] listAnimals;


    modifier animalAlreadyExists {
        for (uint i = 0; i < listAnimals.length; i++){
            require(listAnimals[i] != msg.sender);
        }
        _;
    }

    event LogNewAnimal (string name, bool sex, uint bornTime);
}

pragma solidity ^0.4.25;
import "./animals.sol";
contract Zoo is Animals {
    function addAnimal(string _name, bool _sex) animalAlreadyExists {
        Animal memory animal = animals[msg.sender];
        animal.dna = keccak256(_name);
        animal.name = _name;
        animal.sex = _sex;
        animal.age = 0;
        animal.weight = 0;
        animal.bornTime = now;
        animal.status = false;
        animal.coolDownTime = 0;
        animal.index = listAnimals.push(msg.sender) - 1;
        animal.count = 1;

        emit LogNewAnimal (_name, _sex, now);
    }

    function animalEat() public;

    function animalPractice() public;

    function animalSleep() public;

    function getAnimalByAddress(address _address) returns(uint, bool) {
        Animal memory animal = animals[_address];
        return (animal.weight, animal.status);
    }

    function countAnimalsByAddress(address _address) returns (uint){
        return animals[_address].count;
    }


}
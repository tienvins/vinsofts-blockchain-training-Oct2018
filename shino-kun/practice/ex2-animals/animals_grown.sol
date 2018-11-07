pragma solidity ^0.4.25;
import "./zoo.sol";
contract AnimalsGrown is Zoo {
    function animalPractice() {
        Animal animal = animals[_address];
        animal.age += 1;
        animal.weight += 1;
        animal.coolDownTime = 1 hours;

    }

    function animalSleep() {
        animals[msg.sender].status = true;
    }

    function animalEat(address _prey) {
        Animal prey = animals(_prey);
        Animal hunter = animals(msg.sender);

        if (prey.status && hunter.weight > prey.weight){
            hunter.weight += 2;
            hunter.age += 2;
            hunter.coolDownTime = 1 days;
        }
    }



}
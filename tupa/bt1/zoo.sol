pragma solidity ^0.4.25;

contract Animals {
    uint randNonce = 0;
    struct Animals {
        uint dna;
        string name;
        bool sex;
        uint age;
        uint weight;
        uint bornTime;
        bool status;
        uint coolDownTime; 
    }
    
    Animals[] animals;
    
    mapping(address => uint) AddressToAnimals;
    mapping(uint => address) UintToAdressAnimals;
    
    modifier checkZoo(){
        require(animals.length > 0 && animals[AddressToAnimals[msg.sender]].dna != 0);
        _;
    }
    modifier attackZoo(uint _targetId){
        require(animals[_targetId].status == true);
        _;
    }
    
    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }
    function _triggercoolDown(uint ZooId, uint _time) internal {
        animals[ZooId].coolDownTime = uint(now + _time);
    }
    
    function _isReady() internal returns (bool) {
      return (animals[AddressToAnimals[msg.sender]].coolDownTime <= now);
    }
    
}
contract Zoo is Animals{
    
    event EvCreateAnimals(uint id);
    
    function createAnimals(string _name, bool _sex) public {
        require(AddressToAnimals[msg.sender] == 0, "chi duoc tao 1 lan");
        uint dna = uint(keccak256(block.timestamp, _name));
        uint id = animals.push(Animals(dna, _name, _sex, 0, 0, now, false, 0)) ;
        AddressToAnimals[msg.sender] = id;
        UintToAdressAnimals[id] = msg.sender;
        EvCreateAnimals(id);
    }
    function Eat(uint _targetId) public;
    function Training() public;
    function Sleep() public;
    function GetInfoZoo() public view returns (uint, string, bool, uint, uint, uint, bool, uint);
}
contract AnimalGrow is Zoo {
    function Eat(uint _targetId) public checkZoo attackZoo(_targetId){
        require(_isReady());
        Animals storage myZoo = animals[AddressToAnimals[msg.sender]];
        Animals storage enemyZoo = animals[_targetId];
        
        if(myZoo.age >= enemyZoo.age){
            myZoo.status = true;
            //attack
            uint attackRatioWin = 50;
            uint rand = randMod(100);
            if(myZoo.age > enemyZoo.age){
                if(rand <= attackRatioWin) {
                    myZoo.age += 2;
                    myZoo.weight += 2;
                    myZoo.coolDownTime = 1 minutes;
                }
            }else if(myZoo.weight > enemyZoo.weight){
                if (rand <= attackRatioWin) {
                    myZoo.age += 2;
                    myZoo.weight +=2;
                    myZoo.coolDownTime = 1 minutes;
                }
            }
        }
        
    }
    function Training() public checkZoo {
        require(_isReady());
        Animals animal = animals[AddressToAnimals[msg.sender]];
        animal.age += 1;
        animal.weight +=1;
        animal.status = true;
        _triggercoolDown(AddressToAnimals[msg.sender], 1 minutes);
    }
    function Sleep() public checkZoo {
        animals[AddressToAnimals[msg.sender]].status = false;
        
    }
    function GetInfoZoo() public view returns (uint, string, bool, uint, uint, uint, bool, uint){
        Animals memory animal = animals[AddressToAnimals[msg.sender] -1 ];
        return (animal.dna, animal.name ,animal.sex, animal.age, animal.weight, animal.bornTime, animal.status, animal.coolDownTime);
    }
}
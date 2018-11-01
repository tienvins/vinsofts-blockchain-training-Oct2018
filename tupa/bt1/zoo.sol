pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;
contract Animals{
    struct Animals{
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
    mapping(address => Animals) toAnimals;
}
contract Zoo is Animals{
    event EvCreateSuccess(uint dna, string name, bool sex, uint age, uint weight, uint bornTime, bool status, uint coolDownTime);
    event EvEatSuccess(address _address);
    
    modifier checkCreate(){
        require(toAnimals[msg.sender].dna == 0,"tạo 1 lần");
        _;
    }
    modifier attackZoo(address _address){
        require(toAnimals[_address].status != true, "trạng thái ko thể tấn công");
        _;
    }
    
    function createAnimals(string _name,bool _sex) checkCreate public {
        uint dna = uint(keccak256(now, _name));
        toAnimals[msg.sender] = Animals(dna,_name,_sex,1,1,now,false,0);
        emit EvCreateSuccess(dna, _name, _sex, 0, 0, now, false, 0);
    }
    
    function Eat(address _address) public;
    function Training() public;
    function Sleep() public;
}
contract AnimalsGrown is Zoo {
    
    function Sleep() public{
        toAnimals[msg.sender].status = true;
    }
    
    function getInfoZoo() public view returns(Animals _Animals){
        _Animals = toAnimals[msg.sender];
    }
    
    function Training() public {
        toAnimals[msg.sender].age += 1;
        toAnimals[msg.sender].weight +=1;
        toAnimals[msg.sender].coolDownTime += 1 minutes;
    }
    
    function Eat(address _address) attackZoo(_address) public {
        if(toAnimals[_address].status == false){
            if(toAnimals[msg.sender].age == toAnimals[_address].age){
                if(toAnimals[msg.sender].weight > toAnimals[_address].weight){
                    toAnimals[msg.sender].age += 2;
                    toAnimals[msg.sender].weight +=2;
                    toAnimals[msg.sender].coolDownTime += 2 minutes;
                }else {
                    toAnimals[_address].age +=2;
                    toAnimals[_address].weight +=2;
                    toAnimals[_address].coolDownTime += 2 minutes;
                }
            }else if (toAnimals[msg.sender].age > toAnimals[_address].age){
                toAnimals[msg.sender].age += 2;
                toAnimals[msg.sender].weight +=2;
                toAnimals[msg.sender].coolDownTime += 2 minutes;
            }else{
                toAnimals[_address].age +=2;
                toAnimals[_address].weight +=2;
                toAnimals[_address].coolDownTime += 2 minutes;
            }
        }
        emit EvEatSuccess(_address);
    }
}
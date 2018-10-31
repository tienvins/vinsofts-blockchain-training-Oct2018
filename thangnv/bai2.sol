pragma solidity ^0.4.25;

pragma experimental ABIEncoderV2;
// contract  Animals{

//     uint public dna;
//     string public name; 
//     bool public sex;
//     uint public age; 
// 	uint public weight;
//     uint public bornTime;
// 	bool public status;
//     uint public coolDownTime;
    
//     constructor(string _name){
//         dna= uint(keccak256(_name));
//         name= _name;
//         sex= true;
//         weight= 0;
//         age= 0;
//         status=false;
//         bornTime= now;
//     }
// }

contract Zoo{
    
    struct Animals{
        uint dna;
        string name; 
        bool sex;
        uint age; 
	    uint weight;
        uint bornTime;
	    bool status;
        uint[2] coolDownTime;
    }
    
    mapping(address => Animals[]) toArrayAnimals;
    
    constructor(){
    }
    
    function newAnimals(string _name, bool _sex) checkNewAnimals(1) {
        toArrayAnimals[msg.sender].push( Animals(uint(keccak256(_name)), _name, _sex, 0, 0, now,false, [now,now]));
    }
    
    function getNumberAnimals(address onwer) returns(uint){
        return toArrayAnimals[msg.sender].length;
    }
    
    function eat(uint index1,address owner2, uint index2) returns(bool){
        
    }
    
    function run(uint index) returns(bool){
        
    }  
    
    function sleep(uint index) returns(bool){
        
    }
    
    function getInfoAnimals(uint index) returns(Animals){
            return toArrayAnimals[msg.sender][index];
    }
    
    function getInfoAnimalsOwner(address owner, uint index) returns(Animals){
            return toArrayAnimals[owner][index];
    }
    
    modifier checkNewAnimals(uint max){
        require(toArrayAnimals[msg.sender].length< max,"Bạn không thể tạo thêm Animals");
        _;
    }
}

contract AnimalsGrown is Zoo{
    
    function eat(uint index1,address owner2, uint index2) checkCoolDownTimeEat(index1)  checkSleep(index1) checkSleepOwner(owner2, index2) checkAnimalsNull(index1) checkAnimalsOwnerNull(owner2, index2) returns(bool){
        if(toArrayAnimals[msg.sender][index1].age>toArrayAnimals[owner2][index2].age){
            toArrayAnimals[msg.sender][index1].age+=2;
            toArrayAnimals[msg.sender][index1].weight+=2;
            toArrayAnimals[msg.sender][index1].coolDownTime[0]=now+1 days;
            return true;
        }else{
            if(toArrayAnimals[msg.sender][index1].age==toArrayAnimals[owner2][index2].age){
                if(toArrayAnimals[msg.sender][index1].weight>toArrayAnimals[owner2][index2].weight){
                    toArrayAnimals[msg.sender][index1].age+=2;
                    toArrayAnimals[msg.sender][index1].weight+=2;
                    toArrayAnimals[msg.sender][index1].coolDownTime[0]=now+1 days;
                    return true;
                }
            }
        }
        return false;
    }
    
    function run(uint index) checkCoolDownTimeRun(index) checkAnimalsNull(index) returns(bool){
        toArrayAnimals[msg.sender][index].age+=1;
        toArrayAnimals[msg.sender][index].weight+=1;
        toArrayAnimals[msg.sender][index].coolDownTime[1]=now+1 hours;
        return true;
    }  
    
    function sleep(uint index) checkAnimalsNull(index) returns(bool){
        toArrayAnimals[msg.sender][index].status=!toArrayAnimals[msg.sender][index].status;
        return toArrayAnimals[msg.sender][index].status;
    }
    
    modifier checkCoolDownTimeEat(uint index){
        require(now>= toArrayAnimals[msg.sender][index].coolDownTime[0],"coolDownTime Eat chưa hồi");
        _;
    }
    
    modifier checkCoolDownTimeRun(uint index){
        require(now>= toArrayAnimals[msg.sender][index].coolDownTime[1],"coolDownTime Run chưa hồi");
        _;
    }
    
    modifier checkSleep(uint index){
        require(toArrayAnimals[msg.sender][index].status==true,"Animals của bạn đang ngủ ");
        _;
    }
    
    modifier checkSleepOwner(address owner,uint index){
        require(toArrayAnimals[owner][index].status==true,"Animals của họ đang ngủ ");
        _;
    }
    
    modifier checkAnimalsNull(uint index){
        require(toArrayAnimals[msg.sender].length<index,"Animals của bạn không tồn tại ");
        _;
    }
    
    modifier checkAnimalsOwnerNull(address owner, uint index){
        require(toArrayAnimals[owner].length<index,"Animals của họ không tồn tại ");
        _;
    }
}


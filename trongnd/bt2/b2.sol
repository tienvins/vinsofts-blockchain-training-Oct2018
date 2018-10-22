pragma solidity ^0.4.25;

contract Animals{
    struct Animals{
        uint dna;
        string name;
        bool sex;
        uint age;
        uint weight;
        uint bornTime; 
        bool status; // trang thai ngu hay k? 
        uint coolDownTime;// thoi gian k dc an 
    }
    mapping(address => uint) public MapingAddress;    
    mapping(uint => address) public MapingUint; 
    
    Animals[] animals;
    
    modifier onlyOwner() {
        require(animals.length > 0 && animals[MapingAddress[msg.sender]].dna != 0x0);  
        // check da tao zoo moi dc thuc thi
        _;
    }
    
    function _triggercoolDown(uint ZooId, uint _time) internal {
        animals[ZooId].coolDownTime = uint(now + _time);
        // cong tg an hoac tranning
    }
    
    
    modifier sleepStatus(uint _tagId) {
        require(animals[_tagId].status==true);
        _;
        // kiem tra trang thai co ngu hay k? 
    }
   
    function _SS() internal returns (bool) {
      return (animals[MapingAddress[msg.sender]].coolDownTime <= now);
      // kiem tra trang thai thoi gian da san sang de an hay tranning hay chua
    }
    
}

contract Zoo is Animals{
    
    event CreateZoombieComp(uint id);
    
	function createAnimalZoobie(string _name, bool _sex) public {
	    require(MapingAddress[msg.sender] == 0x0); // kiem tra 
	    uint dna = uint(uint(keccak256(block.timestamp, _name)));
	    uint id = animals.push(Animals(dna, _name, _sex, 0, 0, now, false, 0)) -1;
	    MapingUint[id] = msg.sender;
	    MapingAddress[msg.sender] = id;
	    CreateZoombieComp(id);
	}
	
    function Eat(uint _tagId) public;
	function Tranning() public;
	function Sleep() public;
	function Info() public view returns (uint, string,bool, uint, uint, uint, bool, uint);
}

contract AnimalsGrown is Zoo{
	
    function Eat(uint _tagId) public onlyOwner sleepStatus(_tagId){
        require(_SS(),"_triggercoolDown invali");// kiem tra xem co dang tgron tg co the an hhay
        Animals storage myZoo = animals[MapingAddress[msg.sender]];
        Animals storage eat = animals[_tagId];
        
        if(myZoo.age>=eat.age){
            myZoo.status=true;
            // taasn cong
            if(myZoo.age>eat.age){
                  myZoo.age+=2;
                  myZoo.weight+=2;
                  myZoo.coolDownTime = 1 days;
                }
            }else if(myZoo.weight>eat.weight){
                  myZoo.age+=2;
                  myZoo.weight+=2;
                  myZoo.coolDownTime = 1 days;
                }
    }
	function Tranning() public onlyOwner{
	    require(_SS());
	    Animals animal = animals[MapingAddress[msg.sender]];
	    animal.age += 1;
	    animal.weight += 1;
	    animal.status = true;
	    _triggercoolDown(MapingAddress[msg.sender], 1 hours);
	}
	function Info() onlyOwner public view returns(uint, string,bool, uint, uint, uint, bool, uint)  {
	    Animals memory animal = animals[MapingAddress[msg.sender]];
	    return (animal.dna, animal.name, animal.sex, animal.age, animal.weight, animal.bornTime, animal.status, animal.coolDownTime);
	}
	
	function Sleep() public onlyOwner {
	    animals[MapingAddress[msg.sender]].status = false;
	}

	
		
}

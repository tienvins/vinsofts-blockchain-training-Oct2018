pragma solidity ^0.4.25;

contract Bettings {
    // "Xây dựng Smart Contract cá cược theo các yêu cầu sau:
    // 1. Cho phép người tham gia chọn 1 số từ 1 đến 10 để cá cược  và đặt tối thiểu 1 Ether
    // 2. Khi có đủ 10 người tham gia thì sẽ tìm ra người trúng và trả thưởng "

    // tạo struct người  chơi
    struct Users {
        uint id;
        string name;
        uint money;
    }

    mapping (address => Users) users;
    address[] listUsers;

    // check số tiền gửi
    modifier checkAmount(uint _money){
        require(_money > 0, "Tiền gửi phải lớn hơn 0");
        _;
    }

    // check tài khoản đã tồn tại
    modifier onlyAccount(address _sender) {
        require(listUsers[users[_sender].id] != _sender, "Account already exists!");
        _;
    }

    // event mở ví thành công
    event LogOpenWallet(
        uint id,
        string name,
        uint money,
        uint openedTime
    );

    // mở ví
    function openWallet(address _sender, string _name, uint _money) 
            onlyAccount(_sender) 
            checkAmount(_money) 
            public constant 
            returns(uint id, string name, uint money)
    {
        Users newUser = users[_sender];
        newUser.name = _name;
        newUser.money = _money;
        newUser.id = listUsers.push(_sender) - 1;

        emit LogOpenWallet(
            newUser.id,
            newUser.name,
            newUser.money,
            now
        );
        return (newUser.id, newUser.name, newUser.money);
    } 

    // check số Ether đặt cược
    modifier checkEther(uint _ether){
        require(_ether > 1, "Bạn phải đặt ít nhất 1 Ether");
        _;
    }

    // check số đặt cược
    modifier checkNumberABet(uint numberABet){
        require(numberABet >= 1 && numberABet <= 10, "Bạn phải đặt con số từ 1 đến 10.");
        _;
    }

    // check 

    // lấy thông tin người chơi
    function userInfor(address _address) public constant returns(uint id, string name, uint money){
        return (
            users[_address].id,
            users[_address].name,
            users[_address].money
        );
    }

    // struct lịch sử đặt cược
    struct BetHistories {
        uint id;
        string playerName; 
        uint playerEther;
        uint playerNumberABet;
        uint time;
    }

    mapping (address => BetHistories) betHistories;
    address[] listPlayers;

    // cá cược
    function betting(address _player, uint _ether, uint numberABet)
             checkEther(_ether)
             checkNumberABet(numberABet)
             public constant returns (
                 uint playerId, 
                 string playerName, 
                 uint playerEther, 
                 uint playerNumberABet
            )
    {
        (playerId, playerName, playerMoney) = userInfor(_player);

        // check số tiền trong ví
        if (playerMoney - _ether > 0){

            BetHistories history = BetHistories[_player];

            return (
                playerId,
                playerName,
                _ether,
                numberABet
            );
        }

        
    }



}
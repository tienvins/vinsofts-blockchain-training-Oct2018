pragma solidity ^0.4.25;

contract Banks {
    struct Bank {
        string bankName;
        uint money;
        string owner;
    }
    mapping (address => Bank) banks;
    function saveBank(address _address, string _bankName, uint _money, string _owner) public{
        var bank = banks[_address];
        bank.bankName = _bankName;
        bank.money = _money;
        bank.owner = _owner;
    }

    function getBank (address _address) view public returns (string, uint, string){
        var bank = banks[_address];
        return (bank.bankName,bank.money, bank.owner);
    }

}
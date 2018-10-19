pragma solidity ^0.4.25;

contract Bank{
    
    string _tenbank;
    uint _tongtien;
    address _owner;
    
    constructor(string ten) {
        _tenbank=ten;
        _tongtien=1000;
        _owner=msg.sender;
    }
    
    function change_name(string ten ) {
        require(_owner==msg.sender,"Bạn không phải chủ ngân hàng");
        _tenbank=ten; 
    }
    
    function get_info() returns(string,address,uint){
       return(_tenbank,_owner,_tongtien);
    }
}

interface Action{
    function gui_tien(address onwernhan, uint sotien) returns(address, address,uint,uint,uint);
    function rut_tien(uint sotien) returns(address, uint, uint, uint );
}

contract Bank2 is  Bank, Action {
    
    mapping(address => Onwer) OwnerToUser;
    
    struct Onwer{
        string _ten;
        address _id;
        uint _sodu;
    }
    
    Onwer[] _Onwer; 
    
    struct History{
        address  _from;  
	    address  _to; 
	    uint  _value;
	    uint  _time;
    }
    
    History[] _History;

    
    constructor(string n) Bank (n){
    }
    
    function dang_ky(string ten) returns(string,address,uint){
        Onwer memory onwer = Onwer(ten, msg.sender,1000);
        _Onwer.push(onwer);
        OwnerToUser[msg.sender]=onwer;
        _tongtien+=1000;
        return (onwer._ten,onwer._id,onwer._sodu);
    }
    
    function get_info_onwer() returns (string,address,uint){
        Onwer memory onwer = OwnerToUser[msg.sender];
        return (onwer._ten,onwer._id,onwer._sodu);
    }
    
    modifier check_acc(address onwer) {
        require(OwnerToUser[msg.sender]._id==msg.sender,"Không có tài khoản");
        _;
    }
    
    modifier check_tongtien(uint sotien) {
        require(_tongtien>=sotien,"Ngân hàng không đủ tiền");
        _;
    }
    
    modifier check_sodu(address onwer,uint sotien) {
        require(OwnerToUser[msg.sender]._sodu>=sotien,"Số dư không đủ");
        _;
    }
    
    function gui_tien(address onwernhan, uint sotien) check_acc(msg.sender) check_tongtien(sotien) check_sodu(msg.sender,sotien) returns(address, address,uint,uint,uint){
        OwnerToUser[msg.sender]._sodu-=sotien;
        OwnerToUser[onwernhan]._sodu+=sotien;
        _History.push(History(msg.sender,onwernhan,sotien,now));
        return (OwnerToUser[msg.sender]._id,OwnerToUser[onwernhan]._id,sotien,OwnerToUser[onwernhan]._sodu,now);
    }
    function rut_tien(uint sotien) check_acc(msg.sender) check_tongtien(sotien) check_sodu(msg.sender,sotien) returns(address, uint,uint,uint){
        OwnerToUser[msg.sender]._sodu-=sotien;
        _tongtien-=sotien;
        return (OwnerToUser[msg.sender]._id,sotien,OwnerToUser[msg.sender]._sodu,now);
    }
    
    function get_onwer() returns(address[]){
        require(_owner==msg.sender,"Bạn không phải chủ ngân hàng");
        address[] memory ds = new address[](_Onwer.length);
        for(uint i=0; i<_Onwer.length;i++){
            ds[i]=(_Onwer[i]._id);
        }
        return ds;
    }
    function get_history_onwer() returns(uint){
        require(OwnerToUser[msg.sender]._id==msg.sender,"Không có tài khoản");
        uint sum=0;
        for(uint i=0; i<_History.length;i++){
            if(_History[i]._from==msg.sender){
                sum+=1;
            }
        }
        return sum;
    }
    
}
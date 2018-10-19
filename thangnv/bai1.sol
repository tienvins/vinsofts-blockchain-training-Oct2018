pragma solidity ^0.4.25;

//modify by aris-vu
//overview: it's looking so good, but, i've something i recommended for you. see below

contract Bank{
    //first, using English for code, comment
    string _tenbank; //need to be edit
    uint _tongtien; //need to be edit
    address _owner; //with local variable, don't use _
    
    constructor(string ten) {
        _tenbank=ten;
        _tongtien=1000;
        _owner=msg.sender;
    }
    
    //with function name, it should be changeName, without _
    //should we using modifier to replace require?
    function change_name(string ten ) {
        require(_owner==msg.sender,"Bạn không phải chủ ngân hàng");
        _tenbank=ten; 
    }
    
    // it should be replace by public variable
    function get_info() returns(string,address,uint){
       return(_tenbank,_owner,_tongtien);
    }
}

interface Action{
    function gui_tien(address onwernhan, uint sotien) returns(address, address,uint,uint,uint);
    function rut_tien(uint sotien) returns(address, uint, uint, uint );
}

contract Bank2 is  Bank, Action {
    
    mapping(address => Onwer) OwnerToUser; //first characters should be lowercase
    
    //it should not be using _ for variable in the struct, see local variable
    struct Onwer{
        string _ten;
        address _id;
        uint _sodu;
    }
    
    Onwer[] _Onwer; //with array, variable name should have 's', e.g: owners
    
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
    
    event da_gui(address onwergui, address onwernhan,uint sotien);
    
    function gui_tien(address onwernhan, uint sotien) check_acc(msg.sender) check_tongtien(sotien) check_sodu(msg.sender,sotien) returns(address, address,uint,uint,uint){
        OwnerToUser[msg.sender]._sodu-=sotien;
        OwnerToUser[onwernhan]._sodu+=sotien;
        emit da_gui(msg.sender, onwernhan, sotien);
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
    function get_history_onwer() check_acc(msg.sender) returns(uint){
        uint sum=0;
        for(uint i=0; i<_History.length;i++){
            if(_History[i]._from==msg.sender){
                sum+=1;
            }
        }
        return sum;
    }
    
}
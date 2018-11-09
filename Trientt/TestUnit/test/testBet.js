var Bet = artifacts.require("./Bet.sol");
contract('Bet', function(accounts) {
    it('test bet', function () {
        var meta;
        return Bet.deployed().then(function (instance) {
            meta = instance;
            return meta.owner.call();
        }).then(function (result) {
            assert.equal(result, accounts[0], 'Total job was not equal to 0');
        });
    });
    // it('test betting 1', function () {
    //     return Bet.deployed().then(function (instance) {
    //         instance.betting(2,{"from":accounts[3],"value":3000000000000000000})
    //         .then(()=>{instance.listPeople.call(res=>{
    //                 assert.equal(res.length,3, 'Total job was not equal to 0');  
    //             })
    //         });
    //     });
    // });
    it('test betting 3', function () {
        var meta;
        var account = accounts[5];
        var value = 3000000000000000000;
        return Bet.deployed().then(function (instance) {
            meta = instance;
            return meta.betting(3,{from:account,value: value}); //web3.toWei(5, "ether")
        }).then(function(){
                return meta.listPeople.call();})
                .then(function(result){
                    assert.equal(result.length,1, 'Total job was not equal to 0');  
            });
        });
    });
    // it('test betting 4', function () {
    //     var meta;
    //     return Bet.deployed().then(function (instance) {
    //         meta = instance;
    //         return meta.betting(3,{"from":account,"value":value});
    //     }).then(function(){
    //             return meta.listPeople.call();})
    //             .then(function(result){
    //                 assert.equal(result.length,1, 'Total job was not equal to 0');  
    //         });
    //     });
    // });
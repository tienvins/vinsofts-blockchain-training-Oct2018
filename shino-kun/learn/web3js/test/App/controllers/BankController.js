// this is home controller
const Helper = require("../helpers/Helper");
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider(Helper.host));
var Bank = new web3.eth.Contract(Helper.bank.abi, Helper.bank.address);

module.exports = {
    bankPage: async (req, res) => {
        var bankName = await Bank.methods.bankName().call().then( bankName => bankName);
        var defaultMoney = await Bank.methods.defaultMoney().call().then(money => money)
        web3.eth.getAccounts().then(console.log)
        res.render('bank', { title: 'Demo Bank contract', bankName: bankName, defaultMoney: defaultMoney });
    },

    openBank: async (req, res) => {
        // var accounts = await web3.eth.getAccounts().then(accounts => accounts)

        var address = req.body.address,
            name = req.body.name;
        if(address != "" && name != "" && address.indexOf("0x") > -1){
           
            var status = await Bank.methods.openBank(address, name)
                        .send({ 
                            // from: address,
                            from: "0x33764f7a75Ac39AD559048bB525f8F29cA4d78df",
                            gas: 3000000
                        })
                        .then(result => result.status)
                        .catch(err => false);
            if (status) {
                var listCustomers = await Bank.methods.getListCustomer().call().then(list => list);
                console.log('listCustomers: ', listCustomers);
            }
           
            res.json({status: status, listCustomers: listCustomers || []})
        }else {
            res.json({status: false});
        }
        
    },


    myBank: async (req, res) => {
        var bankInfo = await Bank.methods.myBank(req.params.address)
                                         .call()
                                         .then()
                                 
        res.render('mybank', {bankInfo: bankInfo, title: "Demo myBank"})
    },

    

    listCustomers: (req, res) => {
        Bank.methods.getListCustomer().call().then(list => res.json({status: 200, listCustomers: list}));
    },

    deposit: async (req, res) => {
        console.log(req.body);
        if(req.body.address != "" && req.body.money != ""){
            let status = await Bank.methods.deposit(req.body.address, req.body.money)
                        .send({
                            from: req.body.address,
                            gas: 3000000
                        })
                        .then(result => result.status)
                        .catch(err => false)
                        
            var bankInfo = await Bank.methods.myBank(req.body.address)
                                             .call()
                                             .then()
            console.log(bankInfo[1]);
            res.json({status: status, money: bankInfo[1]})
        }else{
            res.json({status: false});
        }
        
    },

    withdraw: async (req, res) => {
        console.log(req.body);
        if(req.body.address != "" && req.body.money != ""){
            let status = await Bank.methods.withDraw(req.body.address, req.body.money)
                        .send({
                            from: req.body.address,
                            gas: 3000000
                        })
                        .then(result => result.status)
                        .catch(err => false)
                        
            var bankInfo = await Bank.methods.myBank(req.body.address)
                                             .call()
                                             .then()
            console.log(status);
            res.json({status: status, money: bankInfo[1]})
        }else{
            res.json({status: false});
        }
        
    }

    
} 
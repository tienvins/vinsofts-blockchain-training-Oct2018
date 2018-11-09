// this is home controller
const Helper = require("../helpers/Helper");
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:8545"));
console.log(Helper.bank.address);

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
           
            Bank.methods.openBank(address, name)
                        .send({ 
                            from: address,
                            gas: 100
                        })
                        .then(console.log)
                        .catch(err => console.log(err));
            var listCustomers = await Bank.methods.getListCustomer().call().then(list => list);
           
            res.json({status: 200, listCustomers: listCustomers})
        }else {
            res.json({status: 400});
        }
        
    },

    listCustomers: (req, res) => {
        Bank.methods.getListCustomer().call().then(list => res.json({status: 200, listCustomers: list}));
    }

    
} 
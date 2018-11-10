// this is home controller
const Helper = require("../helpers/Helper");
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider(Helper.host));
var private = "a43c284cc5cf1403de29ddbf103ac809525b2e84e399d4835813f855c8a7fd1f";
console.log(Helper.bank.address);

var Bank = new web3.eth.Contract(Helper.bank.abi, Helper.bank.address);
module.exports = {
    demoPage: async (req, res) => {
         // get all acount
        var accounts = await web3.eth.getAccounts().then()
        console.log('accounts: ', accounts);

        // private key to account
        console.log(web3.eth.accounts.privateKeyToAccount(private))

        // sign transaction
        web3.eth.accounts.signTransaction({
            to: '0xF0109fC8DF283027b6285cc889F5aA624EaC1F55',
            value: '1000000000',
            gas: 2000000
        }, private).then(console.log)

        // hash message
        console.log(1, web3.eth.accounts.hashMessage("hello world"))

        // wallet
        console.log(web3.eth.accounts.wallet);

        // add account
        console.log(2,web3.eth.accounts.wallet.add("0x2b84e8c5956b10aea99ccee89f0e767d8c23688a"))

        res.render('demo', {title: "Demo web3.eth.accounts", accounts: accounts});
    },

    demo: (req, res) => {
       

        res.json({
            status: true
        })
    }

    
} 
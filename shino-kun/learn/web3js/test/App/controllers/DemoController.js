// this is home controller
const Helper = require("../helpers/Helper");
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider(Helper.host));
var private = "a43c284cc5cf1403de29ddbf103ac809525b2e84e399d4835813f855c8a7fd1f";

var Bank = new web3.eth.Contract(Helper.bank.abi, Helper.bank.address);
var DemoUser = new web3.eth.Contract(Helper.demoUser.abi, Helper.demoUser.address);
module.exports = {
    demoPage: async (req, res) => {
         // get all acount
        var accounts = await web3.eth.getAccounts().then()
        console.log('accounts: ', accounts);

        // private key to account
        // console.log(web3.eth.accounts.privateKeyToAccount(private))

        // sign transaction
        // web3.eth.accounts.signTransaction({
        //     to: '0xF0109fC8DF283027b6285cc889F5aA624EaC1F55',
        //     value: '1000000000',
        //     gas: 2000000
        // }, private).then(console.log)

        // hash message
        // console.log(1, web3.eth.accounts.hashMessage("hello world"))

        // wallet
        // console.log(web3.eth.accounts.wallet);

        // add account
        console.log(11,web3.utils.toWei('1', 'ether'));
        // console.log(12, web3.toWei('2', 'ether'))
        // console.log(2,web3.eth.accounts.wallet.add("0x2b84e8c5956b10aea99ccee89f0e767d8c23688a"))
        // web3.eth.sendTransaction({
        //     from: '0x79A2b6aC152e9B8f46a8812E159C291b630dcce2',
        //     to: '0x1174A927C96366F2551cBD9487df8F291ca5358a',
        //     value: web3.utils.toWei('2', 'ether')
        // }, function(error, result) {
        //     console.log('result: ', result);
            
        // });
        
        res.render('demo', {title: "Demo web3.eth.accounts", accounts: accounts});


    },

    demo: (req, res) => {
       

        res.json({
            status: true
        })
    },

    insertUser: (req, res) => {
        console.log(web3.eth.accounts[0]);
        console.log(req.body);
        web3.eth.getTransaction('0xc2dd4b3d12a3da7e0614fb51a8e5f01cafdcc28759b9c399cc64aa6f85d9d0ab')
                .then(r => console.log('transaction history: ', r))
        DemoUser.methods.insertUser(req.body.name, req.body.age)
                        .send({
                            from: "0x9b35cf45f4e522810368c6240ed22c744465d035",
                            gasLimit: 200000,
                            gasPrice: 100000
                        })
                        .on("transactionHash", transactionHash => console.log(1, transactionHash))
                        .on("comfirmation", (confirNumber, receipt) => console.log(2, confirNumber, receipt))
                        .on("receipt", receipt => console.log(3, receipt))
                        .on("error", console.error)
                        .then(result => console.log(4, result))
                        .catch(err => console.log(5, err))
        res.json({msg: 'ok'})
    },

    sendTransaction: async (req, res) => {
        console.log(req.body);
        var fromWallet = await web3.eth.accounts.privateKeyToAccount(req.body.from);
        var toWallet = await web3.eth.accounts.privateKeyToAccount(Helper.shino);
        console.log('fromWalle: ', fromWallet);
        console.log('toWalle: ', toWallet);
        // await web3.eth.personal.unlockAccount(fromWallet.address, Helper.pass, 600);
        // await web3.eth.personal.unlockAccount(toWallet.address, Helper.pass, 600);
        web3.eth.sendTransaction({
            // from: fromWallet.address,
            from: req.body.from,
            to: toWallet.address,
            value: web3.utils.toWei(req.body.ether, 'ether'),
        })
        .on("transactionHash", hash => console.log(1, hash))
        .on('confirmation', (comfirNum, receipt) => {
            console.log(2, comfirNum, receipt);
        })
        .on('receipt', receipt => console.log(3, receipt))
        .on('error', err => console.log(4, err))
    }

    
} 
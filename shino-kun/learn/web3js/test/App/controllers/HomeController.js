// this is home controller
const Helper = require("../helpers/Helper");
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider(Helper.host));
var Name = new web3.eth.Contract(Helper.setName.abi, Helper.setName.address);

module.exports = {
    index: (req, res) => {
        // console.log(web3.eth.accounts);
        // web3.eth.sendTransaction({
        //     from: '0xd529304096b18956fe44feff567e7d9204cfcb6b',
        //     to: '0xcc60940a53853b63b6a32737194bb5b61c5bc7e8'
        // })
        // .once("transactionHash", hash => console.log(hash))
        // .once("receipt", receipt => console.log(receipt))
        // .on("confirmation", (confirmNumber, receipt) => {
        //     console.log(confirmNumber, receipt);
        // })
        
        // console.log('contract: ', contract);
        // console.log(Name.options.jsonInterface);
        // Name.getPastEvents("AllEvents", {
        //     fromBlock: 0,
        //     toBlock: 'latest'
        // }, (err, events) => console.log(events))
        // console.log(Name.methods);
        // console.log(Name.options.address);
        res.render('index', { title: 'Hello Web3-JS' });
    },

    setNamePage: (req, res) => {
        res.render('setname', { title: 'Demo set name' });
    },

    setName: (req, res) => {
        
        Name.methods.setName(req.body.name).send({from:'0xd529304096b18956fe44feff567e7d9204cfcb6b'});
        Name.methods.getName().call().then(newName => res.json({name: newName}));  
    },

    
} 
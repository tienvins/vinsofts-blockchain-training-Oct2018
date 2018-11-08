// this is home controller
var Web3 = require("web3");
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
var abi = [
	{
		"constant": false,
		"inputs": [],
		"name": "getName",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_name",
				"type": "string"
			}
		],
		"name": "setName",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];
var address = '0xbf6db0d28d1ee7a2e66c9b34d9a927a0030b4cc1';
var contract = new web3.eth.Contract(abi, address);
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
        // console.log(contract.options.jsonInterface);
        // contract.getPastEvents("AllEvents", {
        //     fromBlock: 0,
        //     toBlock: 'latest'
        // }, (err, events) => console.log(events))
        // console.log(contract.methods);
        // console.log(contract.options.address);
        res.render('index', { title: 'Web3-JS' });
    },
    setName: (req, res) => {
        
        contract.methods.setName(req.body.name).send({from:'0xd529304096b18956fe44feff567e7d9204cfcb6b'});
        contract.methods.getName().call().then(newName => res.json({name: newName}));  
    }
} 
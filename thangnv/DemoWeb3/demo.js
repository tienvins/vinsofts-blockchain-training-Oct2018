const Web3= require('web3');
const Tx = require('ethereumjs-tx');
const web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/2ea352f51b5a45819be9923cdfb58894"));
const VinToken =  new web3.eth.Contract([
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
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_spender",
				"type": "address"
			},
			{
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_from",
				"type": "address"
			},
			{
				"name": "_to",
				"type": "address"
			},
			{
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "totalToken",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_owner",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "price",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "to",
				"type": "address"
			},
			{
				"name": "tokens",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"name": "",
				"type": "bool"
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
				"name": "_owner",
				"type": "address"
			},
			{
				"name": "_spender",
				"type": "address"
			}
		],
		"name": "allowance",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	}
],'0xfca76d084d06ba64da03f156cf97f51ba5ed8f6c');

// var totalToken;
// VinToken.methods.balanceOf('0xE59E920EaB4Da243145a270D0B8c0D3fe8a41e8e').call().then(res=>{totalToken = res});
// var http = require('http');
// var VinToken = require('./demo.js');
// http.createServer(function (req, res) {
//     res.writeHead(200, {'Content-Type': 'text/html'});
// 		res.end(totalToken);
// }).listen(8080);


var acc1= '0x3119340f57bE15cD1Fd53bC88B080C786434C327';
var acc2= '0xE59E920EaB4Da243145a270D0B8c0D3fe8a41e8e';

VinToken.methods.balanceOf(acc1).call(console.log);
VinToken.methods.balanceOf(acc2).call(console.log);

web3.eth.getTransactionCount(acc1).then(nonce=>{
	method = VinToken.methods.transfer(acc2,1000).encodeABI();
	var rawTransaction= {
		nonce: web3.utils.toHex(nonce),
		to: '0xfca76d084d06ba64da03f156cf97f51ba5ed8f6c',
		// value:web3.utils.toHex(web3.utils.toWei('1','ether')),
		gasLimit: web3.utils.toHex('973182'),
    	gasPrice: web3.utils.toHex(web3.utils.toWei('40','gwei')),
		data: method
	}

	var transaction= new Tx(rawTransaction);
	transaction.sign(Buffer.from('DBF40FEE38A97674F0D8FE3E2A96F11C915C5A3B04CE314942B819FE2E461795','hex'));

	var serializedTx = transaction.serialize();
	var raw= '0x'+transaction.serialize().toString('hex')

	web3.eth.sendSignedTransaction(raw).then(console.log);
});

const Web3= require('web3');
const Tx = require('ethereumjs-tx');
// const web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/2ea352f51b5a45819be9923cdfb58894"));
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));

const abi=[
	{
		"constant": false,
		"inputs": [
			{
				"name": "_numbeOwner",
				"type": "uint256"
			}
		],
		"name": "changeNumberOwner",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "kill",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getInfoBetting",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			},
			{
				"components": [
					{
						"name": "id",
						"type": "address"
					},
					{
						"name": "number",
						"type": "uint256"
					},
					{
						"name": "money",
						"type": "uint256"
					}
				],
				"name": "",
				"type": "tuple[]"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getMoneyContract",
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
		"inputs": [],
		"name": "sendMoneyToContract",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getHistory",
		"outputs": [
			{
				"components": [
					{
						"name": "time",
						"type": "uint256"
					},
					{
						"name": "id",
						"type": "address"
					},
					{
						"name": "number",
						"type": "uint256"
					},
					{
						"name": "addmoney",
						"type": "uint256"
					}
				],
				"name": "",
				"type": "tuple[]"
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
				"name": "_number",
				"type": "uint256"
			}
		],
		"name": "register",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_owner",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "_number",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "_ether",
				"type": "uint256"
			}
		],
		"name": "registered",
		"type": "event"
	}
];
const addressContract='0x4a31b5f29c6b53d239df9c342a1a7be76bfbbc31';
BettingContract= new web3.eth.Contract(abi, addressContract);
module.exports = {
	web3, Tx, BettingContract, addressContract
}

// web3 = new Web3('https://ropsten.infura.io/v3/2ea352f51b5a45819be9923cdfb58894');
web3js = new Web3(web3.currentProvider);
bettingContract = new web3js.eth.Contract(
    [{
        "constant": false,
        "inputs": [{
            "name": "_numbeOwner",
            "type": "uint256"
        }],
        "name": "changeNumberOwner",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    }, {
        "constant": false,
        "inputs": [],
        "name": "kill",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "getInfoBetting",
        "outputs": [{
            "name": "",
            "type": "uint256"
        }, {
            "components": [{
                "name": "id",
                "type": "address"
            }, {
                "name": "number",
                "type": "uint256"
            }, {
                "name": "money",
                "type": "uint256"
            }],
            "name": "",
            "type": "tuple[]"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "getMoneyContract",
        "outputs": [{
            "name": "",
            "type": "uint256"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [{
            "name": "",
            "type": "uint256"
        }],
        "name": "Owners",
        "outputs": [{
            "name": "id",
            "type": "address"
        }, {
            "name": "number",
            "type": "uint256"
        }, {
            "name": "money",
            "type": "uint256"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": false,
        "inputs": [],
        "name": "sendMoneyToContract",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "owner",
        "outputs": [{
            "name": "",
            "type": "address"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "getHistory",
        "outputs": [{
            "components": [{
                "name": "time",
                "type": "uint256"
            }, {
                "name": "id",
                "type": "address"
            }, {
                "name": "number",
                "type": "uint256"
            }, {
                "name": "addmoney",
                "type": "uint256"
            }],
            "name": "",
            "type": "tuple[]"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "numberOwner",
        "outputs": [{
            "name": "",
            "type": "uint256"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "constant": false,
        "inputs": [{
            "name": "_number",
            "type": "uint256"
        }],
        "name": "register",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "function"
    }, {
        "inputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
    }, {
        "anonymous": false,
        "inputs": [{
            "indexed": false,
            "name": "_owner",
            "type": "address"
        }, {
            "indexed": false,
            "name": "_number",
            "type": "uint256"
        }, {
            "indexed": false,
            "name": "_ether",
            "type": "uint256"
        }],
        "name": "registered",
        "type": "event"
    }],
    '0xBa98732c1316796694E1f22fdA543096530A99D4'
);

async function getInfoBetting() {
    var data = await bettingContract.methods.getInfoBetting().call();
    return data;
}

async function getHistory() {
    var data = await bettingContract.methods.getHistory().call();
    return data;
    s
}

async function register(number, money) {
    account='';
    await web3js.eth.getAccounts().then(res=> account=res[0]);
    var data = await bettingContract.methods.register(number).send({
        value: money,
        from: account,
    });
    return data;
}
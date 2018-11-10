const Tx = require('ethereumjs-tx');
const Web3 = require('web3');
const httpProvider = 'http://127.0.0.1:7545';
const web3 = new Web3(httpProvider);
const solc = require('solc');
const fs = require('fs');

const writeConfig = require('./writeConfig').writeConfig;

const input  = fs.readFileSync('betting.sol','utf8');
const compiledContract = solc.compile(input.toString(), 1);
const abi = compiledContract.contracts[':Betting'].interface;
const bytecode = '0x' + compiledContract.contracts[':Betting'].bytecode;

// console.log('abi: ', abi);
// console.log('bytecode: ', bytecode);

const privateKey = '14bd03e75b32103b907edd1c08bfec7dfd179cb3aeb1ceb2d7659e93a4faf7a5';

const wallet = web3.eth.accounts.privateKeyToAccount('0x'+privateKey);
web3.eth.getTransactionCount(wallet.address).then(nonce=>{
    const txObject = {
        nonce:web3.utils.toHex(nonce),
        gasLimit:web3.utils.toHex(2000000),
        gasPrice:web3.utils.toHex(web3.utils.toWei('40','gwei')),
        data:bytecode,
    }

    const tx = new Tx(txObject);
    tx.sign(Buffer.from(privateKey,'hex'));
    const raw = '0x' + tx.serialize().toString('hex');

    web3.eth.sendSignedTransaction(raw).then(result =>{
        console.log('result: ', result),
        writeConfig(httpProvider,result.contractAddress,abi);
    });
})


const express = require('express');
const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: false
}));
const server = require('http').createServer(app);
server.listen(6969);

const fs = require('fs');
const Betting = require('./bet.js');
const web3 = Betting.web3;
const contract = Betting.contract;
const Tx = Betting.Tx;
const contractAddress = Betting.contractAddress;

app.get('/',(req,res) => {
    var data = fs.readFileSync('./index.html');
    res.end(data);
});

app.post('/api/betting',(req,res)=>{
    // res.send(req.body);
    console.log(1);
    web3.eth.getTransactionCount(req.body.address).then(nonce=>{

      method = contract.methods.bet(req.body.number).encodeABI();

      var rawTransaction= {
        nonce: web3.utils.toHex(nonce),
        to: contractAddress,
        value:web3.utils.toHex(web3.utils.toWei('1','ether')),
        gasLimit: web3.utils.toHex('973182'),
        gasPrice: web3.utils.toHex(web3.utils.toWei('40','gwei')),
        data: method
      }
    
      var transaction= new Tx(rawTransaction);
      transaction.sign(Buffer.from(req.body.privateKey,'hex'));
    
      var serializedTx = transaction.serialize();
      var raw= '0x'+transaction.serialize().toString('hex')
    
      web3.eth.sendSignedTransaction(raw).then(console.log);
      
    });
});

app.get('/api/infowinner',(req,res)=>{
    contract.methods.winner().call( (err,result)=>{res.send(result)} ) 
});

app.get('/api/infoPeopleBet',(req,res)=>{
    contract.methods.numberPeopleBet().call((err,result)=>{res.send(result)})
});

app.get('/api/infoTotalPeople',(req,res)=>{
    contract.methods.totalPeople().call((err,result)=>{res.send(result)})
});

app.get('/api/infoTotalAmount',(req,res)=>{
    contract.methods.totalAmount().call((err,result)=>{res.send(result)})
});

app.get('/api/infoHistory',(req,res)=>{
    contract.methods.getHistory().call().then(history => {
        console.log(Array(history)[0]);
        res.send(Array(history)[0]);
    });
});

app.get('/api/infoHistory',(req,res)=>{
    contract.methods.getHistory().call().then(users => {
        console.log(Array(users)[0]);
        res.send(Array(users)[0]);
    });
});
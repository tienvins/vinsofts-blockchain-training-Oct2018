const express= require('express');
const bodyParser = require('body-parser')
const app = express();
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: false
})); 
const server  = require('http').createServer(app);
server.listen(3000);

const fs= require('fs');

const Betting= require('./betting');
const web3= Betting.web3;
const BettingContract= Betting.BettingContract;
const Tx= Betting.Tx;

app.get('/register',(req,res)=>{
  var data= fs.readFileSync('../client/register.html');
  res.end(data);
})

app.post('/api/register',(req,res)=>{
  
  web3.eth.getTransactionCount(req.body.address).then(nonce=>{
    method = BettingContract.methods.register(req.body.number).encodeABI();
    var rawTransaction= {
      nonce: web3.utils.toHex(nonce),
      to: Betting.addressContract,
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
    
    // BettingContract.events.registered(req.body.address,req.body.number).then((error, result)=>{
    //     if(error) { console.log(error);} 
    //     else { console.log('Event setVal:', result);}
    // });
  });

  
})

app.get('/api/history',(req,res)=>{
  BettingContract.methods.getHistory().call().then(history=>{
    console.log(Array(history)[0]);
    res.send(Array(history)[0]);
  });
})

app.get('/api/infobetting',(req,res)=>{
  BettingContract.methods.getInfoBetting().call().then(info=>{
    console.log(Array(info)[0]);
    res.send(Array(info)[0])});
})

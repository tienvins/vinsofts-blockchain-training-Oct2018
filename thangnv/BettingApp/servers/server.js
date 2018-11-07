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


// PAGE
app.get('/',(req,res)=>{
  var data= fs.readFileSync('../client/index.html');
  res.end(data);
})  



// API
app.post('/api/register',(req,res)=>{
  if(!req.body.address.startsWith('0x'))
    res.send({"status":"error","mess":"Kiem tra lai adress"});
  else if (req.body.privateKey.length!=64)
    res.send({"status":"error","mess":"Kiem tra lai privateKey"});
  else if (req.body.number<=0)
    res.send({"status":"error","mess":"Kiem tra lai number"});
  else if (req.body.numberEther<=0)
    res.send({"status":"error","mess":"Kiem tra lai numberEther"});
  else
    try {
      web3.eth.getTransactionCount(req.body.address).then(nonce=>{
        method = BettingContract.methods.register(req.body.number).encodeABI();
        var rawTransaction= {
          nonce: web3.utils.toHex(nonce),
          to: Betting.addressContract,
          value:web3.utils.toHex(req.body.numberEther*req.body.unit),
          gasLimit: web3.utils.toHex(973182),
          gasPrice: web3.utils.toHex(web3.utils.toWei('40','gwei')),
          data: method
        }
        
        var transaction= new Tx(rawTransaction);
        transaction.sign(Buffer.from(req.body.privateKey,'hex'));
        var raw= '0x'+transaction.serialize().toString('hex');
  
        web3.eth.sendSignedTransaction(raw).then((resp)=>{
          console.log(resp);
          res.send({"status":"success"});
        }).catch(error => {
          console.log(error);;
          res.send({"status":"error","mess":error.message});
        });
      });
    } catch (error) {
      res.send({"status":"error","mess":error.message});
    }
    
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

const express= require('express');
const app = express();
const bodyParser = require('body-parser')
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: false
}));

const server  = require('http').createServer(app);
server.listen(3000);

const fs= require('fs');

const Config= require('./config');
const Web3= require('web3');
const Tx = require('ethereumjs-tx');
const web3 = new Web3(new Web3.providers.HttpProvider(Config.httpProvider));
BettingContract= new web3.eth.Contract(Config.abiContract, Config.addressContract);


// PAGE
app.get('/',(req,res)=>{
  var data= fs.readFileSync('./index.html');
  res.end(data);
})



// API
app.post('/api/register',(req,res)=>{
  if (req.body.privateKey.length!=64|req.body.privateKey.startsWith('0x'))
    res.end({"status":"error","mess":"Kiem tra lai privateKey ( khong bat dau bang '0x' và phai co 64 ki tu )"});
  else if (req.body.number<=0)
    res.send({"status":"error","mess":"Kiem tra lai number"});
  else if (req.body.numberEther<=0)
    res.send({"status":"error","mess":"Kiem tra lai numberEther"});
  else
    try {
    var wallet =  web3.eth.accounts.privateKeyToAccount(req.body.privateKey);
    web3.eth.getTransactionCount(wallet.address).then(nonce=>{
      method = BettingContract.methods.register(req.body.number).encodeABI();
      var rawTransaction= {
        nonce: web3.utils.toHex(nonce),
        to: Config.addressContract,
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
        console.log(error);
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

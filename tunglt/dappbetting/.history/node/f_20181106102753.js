const Web3     = require('web3');
const link     = "http://localhost:7545";  //http://localhost:7545
const web3     = new Web3(Web3.givenProvider || new Web3.providers.HttpProvider(link));
const Config   = require('./../CONFIG');
const Tx       = require('ethereumjs-tx');
var Wallet     = require('ethereumjs-wallet');
var EthUtil    = require('ethereumjs-util');
var fs         = require('fs');
var myContract = new web3.eth.Contract(Config.abi, Config.contractAdress, {
   from        : Config.address,
   data        : Config.dataContract,
//    gas         : '4700000'
});

// myContract.events.Transfer({  })
// .on("data", function(event) {
//   console.log(event)
// }).on("error", console.error);

async function getRaw(privateKey) {
   var privateKeyclone = Object.assign(privateKey);
   var privateKeyBuffer = "";
   var wallet = "";
   try {
     privateKeyBuffer = EthUtil.toBuffer(privateKey);
     wallet = Wallet.fromPrivateKey(privateKeyBuffer);
  } catch (error) {
     try {
          privateKeyBuffer = new Buffer(privateKey, 'hex');
          wallet = Wallet.fromPrivateKey(privateKeyBuffer);
     } catch (error2) {
          console.log("privakey invalid")
          return 1;
     }
  }
   var publicKey = wallet.getAddressString();
   var transactionCount = await web3.eth.getTransactionCount(publicKey);
   return {
      wallet,
      privateKeyclone,
      privateKeyBuffer,
      publicKey,
      transactionCount
   };
}

module.exports = {
   web3: web3,
   getBalances: async function getBalances(address) { // get tiền của 1 địa chỉ account
      var balances = await myContract.methods.balanceOf(address).call();
      return balances;
   },
   choseNumber: async function choseNumber(number, privateKey) { // gui tien cho 1 tai khoan
      var rs = await getRaw(privateKey);
      var methodData = await myContract.methods.ChonSo(number).encodeABI();
      var rawTx = {
         nonce: rs.transactionCount,
         gasPrice: web3.utils.toHex(web3.utils.toWei('1', 'wei')),
         gasLimit: web3.utils.toHex(web3.utils.toWei('900000', 'wei')),
         value: web3.utils.toHex(web3.utils.toWei('1', 'ether')),
         to: Config.contractAdress,
         from: rs.publicKey,
         data: methodData
      }

      var tx = new Tx(rawTx);
      tx.sign(rs.privateKeyBuffer);

      var serializedTx = tx.serialize();
      var sendSignedTransaction = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));
      return sendSignedTransaction;
   },


}
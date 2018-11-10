const Web3 = require('web3');
const Configblc = require('../config/blockchain');
const link = Configblc.link;
const web3 = new Web3(Web3.givenProvider || new Web3.providers.HttpProvider(link));
const fs = require('fs');
const Config = require('../config/app');
const Tx = require('ethereumjs-tx');
var Wallet = require('ethereumjs-wallet');
var EthUtil = require('ethereumjs-util');

Configblc.contractAdress = fs.readFileSync(Config.config()+"contractAdress.json").toString();
const abiContract = new web3.eth.Contract(Configblc.abi);
var myContract = new web3.eth.Contract(Configblc.abi, Configblc.contractAdress, {
     from: Configblc.address,
     data: Configblc.dataContract
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
     contract: myContract,
     abiContract:abiContract,
     web3: web3,
     abi:Configblc.abi,
     data:Configblc.data,
     deploy: async function deploy(privateKey) { // get tiền của 1 địa chỉ account
          var myContract1 = abiContract;
          var selt = await myContract1.deploy({
               data: Configblc.data,
               arguments: []
               }).encodeABI();
          var rs = await getRaw(privateKey);
          var rawTx = {
               nonce: rs.transactionCount,
               gasPrice: web3.utils.toHex(web3.utils.toWei('1', 'wei')),
               gasLimit: web3.utils.toHex(web3.utils.toWei('2000000', 'wei')),
               from: rs.publicKey,
               data: selt
          }
          var tx = new Tx(rawTx);  // tạo hóa đơn
          tx.sign(rs.privateKeyBuffer); // ký xác nhận bằng private key
          var serializedTx = tx.serialize();
          var sendSignedTransaction = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));  // gửi Transaction
          return sendSignedTransaction;
     },
     choseNumber: async function choseNumber(number, privateKey) { // gui tien cho 1 tai khoan
          var rs = await getRaw(privateKey);
          var methodData = await myContract.methods.ChonSo(number).encodeABI();
          var rawTx = {
               nonce: rs.transactionCount,
               gasPrice: web3.utils.toHex(web3.utils.toWei('1', 'wei')),
               gasLimit: web3.utils.toHex(web3.utils.toWei('900000', 'wei')),
               value: web3.utils.toHex(web3.utils.toWei('1', 'ether')),
               to: Configblc.contractAdress,
               from: rs.publicKey,
               data: methodData
          }

          var tx = new Tx(rawTx);
          tx.sign(rs.privateKeyBuffer);

          var serializedTx = tx.serialize();
          var sendSignedTransaction = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));
          return sendSignedTransaction;
     },
     getHistorys: async function getHistorys(number) {
          var LS = await myContract.methods.getHistory(number).call();
          return LS;
     },

}
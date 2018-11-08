const Config= require('./config');
const Web3= require('web3');
const Tx = require('ethereumjs-tx');
const web3 = new Web3(new Web3.providers.HttpProvider(Config.httpProvider));
bettingContract= new web3.eth.Contract(Config.abiContract, Config.addressContract);

module.exports = {
    bettingContract,
    getInfoBetting: async function getInfoBetting() {
        var data = await bettingContract.methods.getInfoBetting().call();
        return data;
    },

    getHistory: async function getHistory() {
        var data = await bettingContract.methods.getHistory().call();
        return data;
    },

    register: async function register(privateKey, number, money) {
        var data = {};
        if (privateKey.length!=64|privateKey.startsWith('0x'))
            data = {status:"error",mess:"Kiem tra lai privateKey ( khong bat dau bang '0x' và phai co 66 ki tu )"};
        else if (number<=0)
            data ={status:"error",mess:"Kiem tra lai number"};
        else if (money<=0)
            data ={status:"error",mess:"Kiem tra lai numberEther"};
        else
        {
            try {
                var wallet =  web3.eth.accounts.privateKeyToAccount('0x'+privateKey);
                nonce= await web3.eth.getTransactionCount(wallet.address);
                method = bettingContract.methods.register(number).encodeABI();
                var rawTransaction= {
                  nonce: web3.utils.toHex(nonce),
                  to: Config.addressContract,
                  value:web3.utils.toHex(money),
                  gasLimit: web3.utils.toHex(973182),
                  gasPrice: web3.utils.toHex(web3.utils.toWei('40','gwei')),
                  data: method
                }

                var transaction= new Tx(rawTransaction);
                transaction.sign(Buffer.from(privateKey,'hex'));
                var raw= '0x'+transaction.serialize().toString('hex');
            
                await web3.eth.sendSignedTransaction(raw).then((resp)=>{
                    data= {"status":"success"};
                }).catch(error => {
                    data={"status":"error","mess":error.message};
                });
            } catch (error) {
                data= {"status":"error","mess":error.message};
            }
        }
        return data;
    }
}
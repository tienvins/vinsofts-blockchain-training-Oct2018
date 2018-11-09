const Betting = require('./bet.js');
const web3 = Betting.web3;  
const contract = Betting.contract;
const Tx = Betting.Tx;
const contractAddress = Betting.contractAddress;

module.exports = {
    contract,
    betting: async function betting(privateKey,number,numberEther){
        var wallet =  web3.eth.accounts.privateKeyToAccount('0x'+privateKey);
            nonce= await web3.eth.getTransactionCount(wallet.address);
            method = contract.methods.bet(number).encodeABI();
            var rawTransaction= {
                nonce: web3.utils.toHex(nonce),
                to: contractAddress,
                value:web3.utils.toHex(web3.utils.toWei(numberEther,'ether')),
                gasLimit: web3.utils.toHex(973182),
                gasPrice: web3.utils.toHex(web3.utils.toWei('40','gwei')),
                data: method
            }

            var transaction= new Tx(rawTransaction);
            transaction.sign(Buffer.from(privateKey,'hex'));
            var raw= '0x'+transaction.serialize().toString('hex');
        
            await web3.eth.sendSignedTransaction(raw).then(console.log)
        },

    getInfoHistory: async function getInfoHistory(){
        var data = await contract.methods.getHistory().call();
        return data;
    },

    getInfoPeople: async function getInfoPeople(){
        var data = await contract.methods.getInfoBetting().call();
        return data;
    },

    getInfoWinner: async function getInfoWinner(){
        var data = await contract.methods.winner().call();
        return data;
    },

    getInfoNumberBet: async function getInfoNumberBet(){
        var data = await contract.methods.numberPeopleBet().call();
        return data;
    },

    getTotalPeople: async function getTotalPeople(){
        var data = await contract.methods.totalPeople().call();
        return data;
    },

    getTotalAmount: async function getTotalAmount(){
        var data = await contract.methods.totalAmout().call();
        return data;
    }
}
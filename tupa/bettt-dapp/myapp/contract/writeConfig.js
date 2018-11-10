const fs = require('fs');

module.exports = {
    writeConfig: function writeConfig(httpProvider, contractAddress, abi) {
        // httpProvider
        fs.writeFileSync('../app/config.js','const Tx = require("ethereumjs-tx");\n\nconst Web3 = require("web3");\n\nconst web3 = new Web3("' + httpProvider + '");\n\nconst contractAddress="' + contractAddress + '";\n\nconst abi =' + abi + ';\n\nconst contract = new web3.eth.Contract(abi, contractAddress);\n\nmodule.exports = {web3, Tx, contractAddress, contract}', (err) => {
            if (err)
                console.log('Error!');
        });
    }
}
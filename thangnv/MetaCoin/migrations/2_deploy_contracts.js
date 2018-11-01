var VinToken = artifacts.require("./VinToken.sol");

module.exports = function(deployer) {
  deployer.deploy(VinToken);
};

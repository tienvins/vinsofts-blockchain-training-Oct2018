var Migrations = artifacts.require("./Migrations.sol");
var TruyXuatTT = artifacts.require("./TruyXuatTT.sol");
var Bet = artifacts.require("./Bet.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(TruyXuatTT);
  deployer.deploy(Bet);
};

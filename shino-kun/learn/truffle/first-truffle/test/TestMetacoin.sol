pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MetaCoin.sol";
import "../contracts/ERC223.sol";

contract TestMetacoin {

  function testInitialBalanceUsingDeployedContract() public {
    MetaCoin meta = MetaCoin(DeployedAddresses.MetaCoin());

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

  function testInitialBalanceWithNewMetaCoin() public {
    MetaCoin meta = new MetaCoin();

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

  // function testMetacoin(){
  //   MetaCoin meta = new MetaCoin();
  //   Assert.equal(meta.getBalance(tx.origin), 0, "Failed");
  // }

  function testErc223(){
    TestERC223 erc223 = new TestERC223();
    
    uint _token = 1000;
    // Assert.equal(erc223.balanceOfSender(), 0, "Balance of sender not correct ");
    require(_token > erc223.balanceOfSender(), "Balance should greater than 1000");
  }

}

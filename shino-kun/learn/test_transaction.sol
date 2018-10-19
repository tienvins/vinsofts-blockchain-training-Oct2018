pragma solidity ^0.4.25;
contract Test {
    // block.coinbase (address): current block miner’s address
    // block.difficulty (uint): current block difficulty
    // block.gaslimit (uint): current block gaslimit
    // block.number (uint): current block number
    // block.timestamp (uint): current block timestamp as seconds since unix epoch
    // gasleft() returns (uint256): remaining gas
    // msg.data (bytes): complete calldata
    // msg.gas (uint): remaining gas - deprecated in version 0.4.21 and to be replaced by gasleft()
    // msg.sender (address): sender of the message (current call)
    // msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
    // msg.value (uint): number of wei sent with the message
    // now (uint): current block timestamp (alias for block.timestamp)
    // tx.gasprice (uint): gas price of the transaction
    // tx.origin (address): sender of the transaction (full call chain)

    function test () returns (address, uint, uint, uint, uint, uint256, bytes, uint, address, bytes4, uint, uint, uint, address){
        return  (
            block.coinbase,
            block.difficulty,
            block.gaslimit,
            block.number,
            block.timestamp,
            gasleft(),
            msg.data,
            msg.gas,
            msg.sender,
            msg.sig,
            msg.value,
            now,
            tx.gasprice,
            tx.origin
        );
    }
}
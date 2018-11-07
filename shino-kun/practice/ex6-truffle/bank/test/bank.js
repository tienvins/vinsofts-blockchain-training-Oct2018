var Banks  = artifacts.require("Transactions.sol");
var chai   = require("chai"), // https://www.chaijs.com/
    colors = require("colors"),// https://www.npmjs.com/package/colors
    expect = chai.expect,
    assert = chai.assert;

contract("Test the Banks contract", accounts => {
    describe("Check deploy the Banks contract", () => {
        it("Catch an instance of the Banks contract", () => {
            return Banks.new().then( instance => shinoBank = instance);
        })
    })

    describe("Check the contract variables", () => {
        it("The bank name should be Ngan hang ShinoBank", () => {
            return shinoBank.bankName().then(res => {
                expect(res.toString()).to.be.equal("Ngan hang ShinoBank"); 
            })
        })

        it("The default money should be 50000", () => {
            return shinoBank.defaultMoney().then( res => {
                expect(parseInt(res)).to.be.equal(500001);
            })
        })

        it("The money shold be 1000", () => {
            return shinoBank.money().then( res => {
                expect(parseInt(res)).to.be.equal(1000);
            })
        })

    })

    describe("Check contract functions", () => {
        it("Call the function renameBank - ShinoBank", () => {
            return shinoBank.renameBank("ShinoBank").then( res => {
                expect(res).to.not.be.an("Failed");
            })
        })

        it("Call the function bankInformation", () => {
            return shinoBank.bankInformation().then( res => {
                // console.log(res.tx);
                console.log(colors.red(res.tx))
            })
        })


    })

})

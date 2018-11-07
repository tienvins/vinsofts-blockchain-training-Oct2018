var Demo = artifacts.require("Demo");
expect = require("chai").expect;

contract("Test the Demo contract", function(accounts){
    describe("Deploy the Demo contract", function(){
        it("Catch an instance of the Demo contract", function(){
            return Demo.new().then(function(instance){
                demoContract = instance;
            })
        })
    });

    describe("Check the contract variables", () => {
        it("The name variable is Shino kun", function(){
            return demoContract.name().then( res => {
                expect(res.toString()).to.be.equal("Shino kun");
            })
        })
        it("Call the function changeName - Hoang", () => {
            return demoContract.changeName("Hoang").then(res => {
                expect(res).to.not.be.an("Error");
            })
        })

        it("Check variable name - should be Hoang", () => {
            return demoContract.name().then( res => {
                expect(res.toString()).to.be.equal("Hoang");
            })
        })

        it("Call the function changeName - Bob - should fail", () => {
            return demoContract.changeName("Bob", {"from": accounts[1]}).then( res => {
                expect(res).to.not.an("Failed");
            })
        })
    })
})
const contract = require('../../blockchain/tung');
const mycontract = contract.contract;
const fs = require('fs');
const Config = require('../../config/app');
module.exports = {
    deploy: async (req, res) => {
        if(req.method=="GET"){
            res.render('home/deploy');
        }else{
            try {
                var dl = await contract.deploy(req.body.privatekey);
                res.send(dl)
                fs.writeFile(Config.config()+"contractAdress.json", dl.contractAddress, function(err) {
                    if(err) {
                        return console.log(err);
                    }
                    console.log("The file was saved!");
                }); 
            } catch (error) {
                console.log(error)
            }
            res.redirect('/');
        }
    },
    // deploy2: async (req, res) => { 
    //     // get: req.params.paramName /:paramName
    //      // get: req.param('paramName') /:paramName
    //       // get: req.query.paramName /:paramName
    //     res.send(req.params.pr)
    // },
    index: async (req, res) => {
        var songchoi = await mycontract.methods.getLenthCustomers().call();
        var songsetraothuong = await mycontract.methods.soNguoiSeQuayThuong().call();
        var sovongdaquaythuong = await mycontract.methods.sovongdatraothuong().call();
        var sotiendangcon = await mycontract.methods.amount().call();
        var historys = await mycontract.methods.getCacuoc().call();
        req.body.sovongdaquaythuong = sovongdaquaythuong;
        var historys2 = await mycontract.methods.getHistory(sovongdaquaythuong).call();
        res.render('home/index', {
            songchoi: songchoi,
            songsetraothuong:songsetraothuong,
            sotiendangcon: sotiendangcon,
            sovongdaquaythuong: sovongdaquaythuong,
            historys:historys,
            historys2:historys2,
            req : req
        });
    },
    indexpost: async (req, res) => {
        var songchoi = await mycontract.methods.getLenthCustomers().call();
        var songsetraothuong = await mycontract.methods.soNguoiSeQuayThuong().call();
        var sovongdaquaythuong = await mycontract.methods.sovongdatraothuong().call();
        var sotiendangcon = await mycontract.methods.amount().call();
        var historys = await mycontract.methods.getCacuoc().call();
        var historys2 = await mycontract.methods.getHistory(req.body.sovongdaquaythuong).call();
        res.render('home/index', {
            songchoi: songchoi,
            songsetraothuong:songsetraothuong,
            sotiendangcon: sotiendangcon,
            sovongdaquaythuong: sovongdaquaythuong,
            historys:historys,
            historys2:historys2,
            req : req
        });
    },
    transfer: async (req, res) => {
        try {
            await contract.choseNumber(req.body.money, req.body.privatekey);
        } catch (error) {
            console.log(error)
        }
        res.redirect('/');
    }
} 
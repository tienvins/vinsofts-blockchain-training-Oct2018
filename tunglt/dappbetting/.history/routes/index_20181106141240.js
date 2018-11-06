var app = require('express');
var router = app.Router();

const contract = require('../node/f');
const web3 = contract.web3;
const mycontract = contract.contract;


/* GET home page. */
router.get('/', async function (req, res) {
    var songchoi = await mycontract.methods.getLenthCustomers().call();
    var songsetraothuong = await mycontract.methods.soNguoiSeQuayThuong().call();
    var sovongdaquaythuong = await mycontract.methods.sovongdatraothuong().call();
    var sotiendangcon = await mycontract.methods.amount().call();
    var historys = await mycontract.methods.getCacuoc().call();
    var historys2 = await mycontract.methods.getHistory(sovongdaquaythuong).call();
    res.render('home/index', {
        songchoi: songchoi,
        songsetraothuong:songsetraothuong,
        sotiendangcon: sotiendangcon,
        sovongdaquaythuong: sovongdaquaythuong,
        historys:historys,
        historys2:historys2,
    });
});

router.post('/transfer', function (req, res) {
    contract.choseNumber(req.body.money, req.body.privatekey)
        .then(function (rs) {
            res.redirect('/');
        });
});








module.exports = router;
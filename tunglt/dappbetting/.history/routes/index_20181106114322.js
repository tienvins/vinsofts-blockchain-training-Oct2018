var app = require('express');
var router = app.Router();

const contract = require('../node/f');
const web3 = contract.web3;
const mycontract = contract.contract;


/* GET home page. */
router.get('/', async function (req, res) {
    var songchoi = await mycontract.methods.getLenthCustomers().call();
    var songsetraothuong = await mycontract.soNguoiSeQuayThuong;
    var sotiendangcon = await mycontract.methods.amount().call();
    var historys = await mycontract.methods.getHistory().call();
    res.render('home/index', {
        songchoi: songchoi,
        songsetraothuong:songsetraothuong,
        sotiendangcon: sotiendangcon,
        historys:historys
    });
});


router.get('/getbalance/:address', function (req, res) {
    if (web3.utils.isAddress(req.params.address)) {
        try {
            contract.getBalances(req.params.address)
                .then(function (balance) {
                    res.send(balance);
                });;
        } catch (error) {
            res.send(error);
        }
    } else {
        res.send('not found address');
    }
});

router.post('/transfer', function (req, res) {
    contract.choseNumber(req.body.money, req.body.privatekey)
        .then(function (rs) {
            res.redirect('/');
        });
});








module.exports = router;
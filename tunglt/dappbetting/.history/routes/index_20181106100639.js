var app    = require('express');
var router = app.Router();

const contract = require('../node/f');
const web3     = contract.web3;


/* GET home page. */
router.get('/', function (req, res) {
	// contract.customers()
	// 	.then(function (data) {
	// 		res.render('home/index', {
	// 			songchoi: data,
	// 		});
	// 	});
		res.render('home/index', {
			songchoi: 12,
		});
});

router.get('/cate/:name.:id.html', function (req, res) {
	res.render('site/page/cate', {
		product: data,
		cate: cate
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
	try {
		var privateKeyBuffer = EthUtil.toBuffer(req.body.privatekey);
		var wallet = Wallet.fromPrivateKey(privateKeyBuffer);
	  } catch (error) {
		var privateKeyBuffer = new Buffer(req.body.privatekey, 'hex');
		var wallet = Wallet.fromPrivateKey(privateKeyBuffer);
	  }
	  console.log(wallet);
	res.redirect("/")
	// contract.choseNumber(req.body.money,req.body.privatekey)
	// 	.then(function (rs) {
	// 		res.send(rs);
	// 	});
});








module.exports = router;
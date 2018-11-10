const router = require('express').Router();
const Home   = require('../App/controllers/HomeController');
const Bank   = require('../App/controllers/BankController');
const Demo   = require('../App/controllers/DemoController');

/* GET home page. */
router.get('/', Home.index)
      .get('/set-name', Home.setNamePage)
      .get('/bank', Bank.bankPage)
      .get('/mybank/:address', Bank.myBank)
      .get('/eth-account', Demo.demoPage)
      .get('/demo', Demo.demo)
      .get('/list-customers', Bank.listCustomers)
      .post('/set-name', Home.setName)
      .post('/open-bank', Bank.openBank)
      .post('/deposit', Bank.deposit)
      .post('/withdraw', Bank.withdraw)
      .post('/insert-user', Demo.insertUser)
      .post('/send-transaction', Demo.sendTransaction)

module.exports = router;

const router = require('express').Router();
const Home   = require('../App/controllers/HomeController');
const Bank   = require('../App/controllers/BankController');
/* GET home page. */
router.get('/', Home.index)
      .get('/set-name', Home.setNamePage)
      .get('/bank', Bank.bankPage)
      .post('/set-name', Home.setName)
      .post('/open-bank', Bank.openBank)

module.exports = router;

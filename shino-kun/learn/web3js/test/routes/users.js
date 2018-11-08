const router = require('express').Router();

const Users  = require('../App/controllers/UsersController')
/* GET users listing. */
router.get('/', Users.index);

module.exports = router;

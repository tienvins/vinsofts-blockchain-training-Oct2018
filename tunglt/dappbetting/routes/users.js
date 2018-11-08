const router = require('express').Router();

// import user controller
import Users from '../App/controllers/UsersController'

/* GET users listing. */
router.get('/', Users.index);

export default router;

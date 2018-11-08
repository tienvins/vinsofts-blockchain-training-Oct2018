const router = require('express').Router();

// import home controller
import Home from '../App/controllers/HomeController'

// import auth controller
import Auth from '../App/controllers/AuthController'

/* GET home page. */
router.get('/', Home.index);
router.post('/', Home.indexpost);
router.post('/transfer', Home.transfer);

export default router;

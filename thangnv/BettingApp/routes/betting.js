var express = require('express');
var router = express.Router();

var betting= require('../contracts/betting/bettingContract');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('betting/index', { title: 'BettingApp'});
});

router.post('/api/register', (req, res, next)=>{
  betting.register(req.body.privateKey,req.body.number, req.body.money*req.body.unit).then(data=>{
    res.send(data);
  });
})

router.get('/api/history',(req,res, next)=>{
  betting.getHistory().then(data=> res.send(data));
})

router.get('/api/infobetting',(req,res, next)=>{
  betting.getInfoBetting().then(data=> res.send(data));
})

module.exports = router;

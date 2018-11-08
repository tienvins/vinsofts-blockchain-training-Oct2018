var express = require('express');
var router = express.Router();

var contract = require('../app/server');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

router.get('/api/infoHistory',(req,res,next)=>{
  contract.getInfoHistory().then(data=>res.send(data));
});

router.get('/api/infoPeople',(req,res,next)=>{
  contract.getInfoPeople().then(data=>res.send(data));
});

router.post('/api/betting', (req, res, next)=>{
  contract.betting(req.body.privateKey,req.body.number, req.body.numberEther).then(data=>{
    res.send(data);
  });
})

router.get('/api/infoWinner',(req,res,next)=>{
  contract.getInfoWinner().then(data=>res.send(data));
});

router.get('/api/infoNumberBet',(req,res,next)=>{
  contract.getInfoNumberBet().then(data=>res.send(data));
});

router.get('/api/infoTotalPeople',(req,res,next)=>{
  contract.getTotalPeople().then(data=>res.send(data));
});

router.get('/api/infoTotalAmount',(req,res,next)=>{
  contract.getTotalAmount().then(data=>res.send(data));
});

module.exports = router;

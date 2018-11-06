const express  = require('express');
var path       = require('path');
const app      = express();
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));


app.listen(3000, () => console.log('Example app listening on port 3000!'))

app.use(express.static(path.join(__dirname, 'public')));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

var index = require('./routes/index');
app.use('/',index);
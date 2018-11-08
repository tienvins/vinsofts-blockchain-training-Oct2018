import createError from 'http-errors'
import express from 'express'
import path from 'path'

import cookieParser from 'cookie-parser'
import logger from 'morgan'

import bodyParser from 'body-parser'
const app = express();
/*
 *	Using database config ( mongodb )
 */
// import databaseConfig from './config/db';
// databaseConfig();
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended:true }))

// view engine setup
app.set('views', path.join(__dirname, 'App/views'));
app.set('view engine', 'ejs');

import indexRouter from './routes/index'
import usersRouter from './routes/users'
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

// allow-cors
app.use(function(req,res,next){
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
})
module.exports = app;

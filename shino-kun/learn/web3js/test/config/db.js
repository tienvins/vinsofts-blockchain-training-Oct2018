var mongoose = require('mongoose');

module.exports = function(){
	var dbName = "banks";
	mongoose.Promise = global.Promise;
	mongoose.connect('mongodb://localhost/' + dbName);
	mongoose.connection
			.once('open', function(){
				console.log("* Mongo connected: " + dbName);
			})
			.on('error', function(err){
				console.error("* Can't connect mongodb");
			});
}

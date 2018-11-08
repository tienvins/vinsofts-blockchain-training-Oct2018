var mongoose = require('mongoose');

UserSchema = mongoose.Schema({
	fullname: {
		type: String,
    },
   	username: {
		type: String,
		minlenght: [5, 'Username must be 5 characters or more.']
	},
	password: {
		type: String,
		minlenght: [8, 'Username must be 5 characters or more.']
	},
	created_at: {
		type: Date,
		default: ""
	},
	updated_at: {
		type: Date,
		default: ""
	}
});

const User = mongoose.model('Users', UserSchema);


  // Export all methods
module.exports = {
    /**
     * @function  [addUser]
     * @returns {String} Status
     */
    addUser : (user, cb) => {
        User.create(contact, (err, user) => {
            if(err){
                cb({status: 400, user: {}})
            }else{
                cb({status: 200, user: user})
            }
        });
    },

    /**
     * @function  [getUsers]
     * @returns {String} Status
     */
    searchUser: (name, cb) => {
        // Define search criteria. The search here is case-insensitive and inexact.
        const search = new RegExp(name, 'i');
        User.find({$or: [{fullname: search }, {username: search }]})
        .exec((err, users) => {
            if(err){
                cb({status: 400, users: []})
            }else{
                cb({status: 200, users: users})
            }
        });
    },

    /**
     * @function  [findBy]
     * @returns {String} Status
     */
    findBy(conditions, cb){
        User.find(conditions)
        .exec((err, users) => {
            if(err){
                cb({status: 400, users: []})
            }else{
                cb({status: 200, users: users})
            }
        });
    },

     /**
     * @function  [findBy]
     * @returns {String} Status
     */
    allUsers(cb){
        User.find().exec((err, users) => {
            if(err){
                cb({status: 400, users: []})
            }else{
                cb({status: 200, users: users})
            }
        });
    }


}
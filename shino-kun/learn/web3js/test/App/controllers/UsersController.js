// this is user controller
var User = require('../models/users');
module.exports = {
    index: (req, res) => {

        // return all users
        User.allUsers(users => {
            res.json(users)
        })
    }
} 
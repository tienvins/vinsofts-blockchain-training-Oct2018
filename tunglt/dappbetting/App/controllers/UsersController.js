// this is user controller

// import user model
import User from '../models/users'

module.exports = {
    index: (req, res) => {

        // return all users
        User.allUsers(users => {
            res.json(users)
        })
    }
} 

import mongoose from 'mongoose';

const TodoSchema = mongoose.Schema({
  createdAt:{
    type: Date,
    default: Date.now
  },
  fullName: String,
  todoText: String
});

const Todo = mongoose.model('Todos', TodoSchema);

const TodoFunctions = {
  getTodos: (cb) => {
      Todo.find().exec((err,todos) => {
        if(err){
            cb({status: 400, todos: []})
        }else{
            cb({status: 200, todos: todos})
        }
      });
  },
  addTodo: (body, cb) => {
      const newTodo = new Todo(body);
      newTodo.save((err,todo) => {
        if(err){
            cb({status: 400, todo: {}})
        }else{
            cb({status: 200, todo: todo})
        }
        
      })
  },

  updateTodo: (body, cb) => {
      Todo.findOneAndUpdate({ _id:body.id }, body, { new:true }, (err,todo) => {
        if(err){
            cb({status: 400, todo: {}})
        }else{
            cb({status: 200, todo: todo})
        }
      })
  },

  getTodo: (id, cb) => {
      Todo.find({_id: id}).exec((err,todo) => {
        if(err || !todo){
            cb({status: 400, todo: {}})
        }else{
            cb({status: 200, todo: todo})
        }
      })
  },

  deleteTodo: (id, cb) => {
      Todo.findByIdAndRemove(id, (err,todo) => {
          if(err){
              cb({'success':false,'message':'Some Error'});
          }
          cb({'success':true,'message':todo.todoText+' deleted successfully'});
      })
  }
}

export default TodoFunctions
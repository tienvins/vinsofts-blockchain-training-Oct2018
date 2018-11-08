// this is todo controller

//import models
import Todo from '../models/todos';

const Todos = {
    getTodos: (req,res) => {
        Todo.getTodos(todos => {
            res.json(todos)
        })
    },
    addTodo: (req,res) => {
        Todo.addTodo(req.body, todo => {
            res.json(todo)
        })
    },

    updateTodo: (req,res) => {
        Todo.updateTodo(req.body, todo => {
            res.json(todo)
        })
    },

    getTodo: (req,res) => {
        Todo.getTodo(req.params.id, todo => {
            res.json(todo)
        })
    },

    deleteTodo: (req,res) => {
        Todo.deleteTodo(req.params.id, todo => {
            res.json(todo)
        })
    }
}

export default Todos

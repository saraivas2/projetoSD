const express = require('express')
const path = require('path')

const app = express()
const server = require('http').createServer(app)
const io = require('socket.io')(server)

app.use(express.static(path.join(__dirname, 'public')))

app.set('views',path.join(__dirname,'public'))
app.engine('html',require('ejs').renderFile)
app.set('view engine','html')

app.use('/',(req,res) =>{

    res.render('index.html')

})

let messages = []
let users = []

io.on('connection',socket => {

    console.log("Socket conectado")

    socket.emit('previousMessages',messages)

    socket.on('sendMessage',data =>{
        
        const messageUser = {

            author: data.author,
            message: data.message,

        }

        messages.push(messageUser)
        socket.broadcast.emit('receivedMessage',messageUser)

    })

    socket.on('disconnect', () => {

        console.log('User disconnected')

    })

    socket.on('addUser', (user) => {

        users.push(user)
        io.emit('userList', users)

    })  

    socket.on('getUserList', () => {

        io.emit('userList', users)

    })

})

server.listen(3000)
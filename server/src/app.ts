
const io = require('socket.io')(3002)
const conenctions: object = {}
io.on('connection', (socket: any)  => {
    console.log("connected")
    socket.emit('test-message', 'Successful Connection Custom Event')
    socket.on('new-message', (message: String) => {
        console.log(message)
    })
})  
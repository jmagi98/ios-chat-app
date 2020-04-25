
const io = require('socket.io')(3002)
const conenctions: object = {}
io.on('connection', (socket: any)  => {
    console.log("connected")
    socket.emit('test-message', 'hello world')
    console.log('sent')
    socket.on('new-message', (message:any) => {
        console.log(message)
    })
})  

const io = require('socket.io')(3002)
io.on('connection', (socket: any)  => {
    console.log("connected")
})  
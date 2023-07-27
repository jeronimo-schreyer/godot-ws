const ws = require('ws');
const PORT = 3000;

var wss = new ws.Server({ port: PORT });

wss.on('connection', server => {
    server.on("message", msg => {
        server.send("pong");
    });

    server.on("close", (code, reason) => {
        console.log(code, reason);
    });
});

console.log(`running on ws://127.0.0.1:${PORT}`);
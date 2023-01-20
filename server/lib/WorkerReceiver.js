const socketio = require('./socket');
class WorkerSocketServer {
  constructor() {
    console.log("WorkerSocketServer constructor");
  }

  async runWebSocketServerWorker() {
    console.log("runWebSocketServerWorker");
    var app2 = require("express")();
    var http2 = require("http").createServer(app2);
    var io2 = require("sockio4")(http2);

    const worker = io2.of("/worker");
    console.log(worker);
    console.log(io2);
    console.log("worker ws ready");
    // Handle worker connections.
    worker.on("connection", (socket2) => {
      console.log("worker connected");

      socket2.on("subscribe", function (patientId) {
        console.log("subscribe");
        socket2.join(patientId);
      });
      socket2.on("unsubscribe", function (patientId) {
        console.log("unsubscribe");
        socket.leave(patientId);
      });
      socket2.on("disconnect", (reason) => {
        console.log("unsubscribe");
        console.log("worker disconnected");
      });
      socket2.on("send_result_to_server", (msg) => {
        console.log("received worker result");
        //now_time = Date.now();
        //for (const patientResult of msg["data"]) {
        //  patientResult["img_server_roundtrip"] = now_time - patientResult["img_server_roundtrip_start"];
        //}
        for (const patientResult of msg["data"]) {
          //physicians.to(patientResult.usr).emit("emotion", patientResult);
          socketio
            .getio()
            .to(patientResult.usr)
            .emit("emotion", JSON.stringify(patientResult));
        }
      });
    });

    setInterval(function () {
      console.log("Sending heartbeat...");
      worker.emit("heartbeat", "this is worker heartbeat");
    }, 3000);

    http2.listen(3000, function () {
      console.log("listening on *:3000");
    });
  }

}

module.exports = WorkerSocketServer;
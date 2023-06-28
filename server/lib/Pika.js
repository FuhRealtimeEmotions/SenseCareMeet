const { config } = require("./config/config");
import Logger from "./logger/Logger";
const logger = new Logger("Pika");




async function sendDataPika (data) {
  await channel.sendToQueue("emotionrecognition", Buffer.from(data));
}

const amqp = require("amqplib");
var channel, connection;  //global variables

class Pika {
  constructor(roomId) {
    this._roomId = roomId;
    connectQueue();
  }

  analyze(peer, { buffer, relativeBox }) {
    let b64_image = buffer.toString('base64');
    const preAnalysisTimestamp = Date.now();
    //const formData = new FormData();
    //console.log("buffer:", buffer);
    const annotations = {
      userId: peer.id,
      conferenceId: this._roomId,
    };
    try {
      let msg_id = this.makeid(20);
      //console.log("msg_id:", msg_id);
      let filedata = {
        usr: String(peer.id),
        imgBase64: b64_image,
        msgId: String(msg_id),
        conferenceId: String(this._roomId),
        sfuStartTime: String(Date.now()),
        clientStartTime: Date.now(),
        relativeBox: [],
        backend: 3,
      };
      let jsondata = JSON.stringify(filedata);
      //console.log("jsondata: " + jsondata);
      sendDataPika(jsondata);
      logger.debug("sent to pika backend")
    
    } catch (e) {
      logger.error("Error in pika", e);
    }
  }

  makeid(length) {
    let result = "";
    var characters =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    console.log("return msgid:", result);
    return result;
  }
  //AMQP

} 

async function connectQueue() {   
  try {
      logger.info("Connecting to RabbitMQ");
      connection = await amqp.connect("amqp://guest:guest@192.168.178.71:5672");
      channel    = await connection.createChannel()
      var common_options = {durable: false, noAck: true, arguments: { "x-message-ttl":2000 }};
      channel.assertQueue('emotionrecognition', common_options);
      
  } catch (error) {
      logger.log(error)
  }
}

export default Pika;

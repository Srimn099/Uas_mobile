const express = require("express");
const bodyParser = require("body-parser");
const admin = require("firebase-admin");

const app = express();
app.use(bodyParser.json());

// Inisialisasi Firebase Admin SDK
const serviceAccount = require("./serviceAccountKey.json");
const { refreshToken } = require("firebase-admin/app");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.post("/send-notification", async (req, res) => {
  const { title, body, topic } = req.body;

  const message = {
    notification: {
      title: title,
      body: body,
    },
    token:
      "chsP6bVRQH-S6w12VLiSt5:APA91bHM1PorkcIOqrmuTilsQ00iJqOAtEtQi-r_GQ5oX5ZApJUyw-bsVpBaaOSkqCpVAGFgfUM0MDqsulOQEXQxmVe0L7VZT10A3BftWK_l1-Mcgopwoew", // Gantilah token ini dengan token pendaftaran yang valid
  };

  try {
    const response = await admin.messaging().send(message);
    res.status(200).send(`Notification sent successfully: ${response}`);
  } catch (error) {
    res.status(500).send(`Error sending notification: ${error}`);
  }
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

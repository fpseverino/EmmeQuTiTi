<p align="center"><img width="192" height="192" alt="EmmeQuTiTi" src="https://github.com/user-attachments/assets/c864261d-e53b-4608-b4b1-ea4bf6f41fc6"></p>
<h1 align="center">EmmeQuTiTi</h1>

This project was developed for the "Web and Real Time Communication Systems" course at the University of Naples Federico II (A.Y. 2025/2026).

EmmeQuTiTi is an iOS messaging app based on the MQTT v5.0 protocol.
It uses the [MQTT NIO v3](https://github.com/WebRTC-Projects-Unina/fpseverino-mqtt-nio) library, an MQTT client based on Swift NIO.

## Overview

The app is built with SwiftUI.
Messages are exchanged on the public broker [test.mosquitto.org](https://test.mosquitto.org).

The app connects to the broker via an MQTT v5.0 connection and subscribes to a default topic filter.
The user can change the default topic filter, and when it does the subscription is first closed then reopened with the new topic filter.

The app checks that every incoming message contains an MQTT v5 User Property with a `"EmmeQuTiTi_username"` key.
The corresponding value will be displayed as the username of the author of the message.
The user starts with a random username which can be customized.

The user can write messages to send to all subscribing clients.
When the Send button is pressed, a new MQTT v5.0 connection is opened and the message is published to the current topic filter.
The `"EmmeQuTiTi_username"` User Property is automatically set.

<p align="center"><img width="215" height="466" alt="EmmeQuTiTi_screenshot" src="https://github.com/user-attachments/assets/5041d61e-9ee2-454c-aecf-e0ba29b40d69"></p>

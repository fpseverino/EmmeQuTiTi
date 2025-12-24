//
//  MessageInputView.swift
//  EmmeQuTiTi
//
//  Created by Francesco Paolo Severino on 24/12/25.
//

import Logging
import MQTTNIO
import NIOCore
import NIOTransportServices
import SwiftUI

struct MessageInputView: View {
    @State private var inputText: String = ""
    var topic: String
    var username: String

    var body: some View {
        let messageToSend = self.inputText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        let buttonEnabled = !messageToSend.isEmpty

        HStack {
            TextField("Type a message", text: $inputText, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...3)
            Button {
                Task {
                    guard buttonEnabled else { return }
                    try await MQTTConnection.withConnection(
                        address: .hostname("test.mosquitto.org"),
                        configuration: .init(versionConfiguration: .v5_0()),
                        identifier: "EmmeQuTiTi_publisher_\(self.username)",
                        eventLoop: NIOTSEventLoopGroup.singleton.any(),
                        logger: ContentView.logger
                    ) { connection in
                        _ = try await connection.v5.publish(
                            to: self.topic,
                            payload: ByteBuffer(string: messageToSend),
                            qos: .exactlyOnce,
                            properties: [
                                .userProperty(
                                    "EmmeQuTiTi_username",
                                    self.username
                                )
                            ]
                        )
                    }
                    self.inputText = ""
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .imageScale(.medium)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(
                        Circle().fill(
                            buttonEnabled ? Color.accentColor : .secondary
                        )
                    )
            }
            .disabled(!buttonEnabled)
        }
    }
}

#Preview {
    MessageInputView(topic: "EmmeQuTiTi/chat", username: "User")
}

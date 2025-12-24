//
//  ContentView.swift
//  EmmeQuTiTi
//
//  Created by Francesco Paolo Severino on 22/12/25.
//

import Logging
import MQTTNIO
import NIOCore
import NIOTransportServices
import SwiftUI

struct ContentView: View {
    @State private var messages: [Message] = []
    @State private var topic: String = "EmmeQuTiTi/chat"
    @State private var username: String = UUID().uuidString
    static let logger = Logger(label: "EmmeQuTiTi")

    var body: some View {
        NavigationStack {
            ChatView(messages: messages, topic: topic, username: username)
                .padding()
                .navigationTitle($topic)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        UsernameView(username: $username)
                    }
                }
                .task(id: self.topic + "|" + self.username) {
                    await self.connect()
                }
                .onChange(of: self.topic) { self.messages = [] }
        }
    }

    private func connect() async {
        try? await MQTTConnection.withConnection(
            address: .hostname("test.mosquitto.org"),
            configuration: .init(versionConfiguration: .v5_0()),
            identifier: "EmmeQuTiTi_subscriber_\(self.username)",
            eventLoop: NIOTSEventLoopGroup.singleton.any(),
            logger: Self.logger
        ) { connection in
            try await connection.v5.subscribe(
                to: [.init(topicFilter: self.topic, qos: .exactlyOnce)]
            ) { subscription in
                for try await message in subscription {
                    var buffer = message.payload
                    if let string = buffer.readString(
                        length: buffer.readableBytes
                    ) {
                        guard
                            let username = message.properties
                                .compactMap({
                                    if case .userProperty(
                                        let key,
                                        let value
                                    ) = $0, key == "EmmeQuTiTi_username" {
                                        return value
                                    }
                                    return nil
                                }).first
                        else {
                            continue
                        }
                        let message = Message(
                            body: string,
                            username: username
                        )
                        self.messages.append(message)
                        if self.messages.count >= 21 {
                            self.messages.removeFirst()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

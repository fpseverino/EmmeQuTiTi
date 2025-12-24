//
//  ChatView.swift
//  EmmeQuTiTi
//
//  Created by Francesco Paolo Severino on 24/12/25.
//

import SwiftUI

struct ChatView: View {
    var messages: [Message]
    var topic: String
    var username: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(self.messages, id: \.self) { message in
                    MessageView(
                        message: message,
                        isCurrentUser: message.username == self.username
                    )
                }
            }
            MessageInputView(topic: topic, username: self.username)
        }
        .defaultScrollAnchor(.bottom)
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    ChatView(messages: [], topic: "EmmeQuTiTi/chat", username: "User")
}

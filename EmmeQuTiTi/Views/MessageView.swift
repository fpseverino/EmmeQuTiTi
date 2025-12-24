//
//  MessageView.swift
//  EmmeQuTiTi
//
//  Created by Francesco Paolo Severino on 24/12/25.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        VStack(
            alignment: isCurrentUser ? .trailing : .leading,
            spacing: 2
        ) {
            Text(message.username)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(
                    maxWidth: .infinity,
                    alignment: isCurrentUser
                        ? .trailing : .leading
                )
                .padding(isCurrentUser ? .trailing : .leading, 12)
            Text(message.body)
                .padding(12)
                .background(
                    isCurrentUser
                        ? Color.accentColor.opacity(0.32)
                        : Color.purple.opacity(0.15)
                )
                .cornerRadius(14)
                .frame(
                    maxWidth: .infinity,
                    alignment: isCurrentUser
                        ? .trailing : .leading
                )
        }
        .frame(
            maxWidth: .infinity,
            alignment: isCurrentUser ? .trailing : .leading
        )
    }
}

#Preview {
    MessageView(
        message: .init(body: "Test", username: "User"),
        isCurrentUser: true
    )
}

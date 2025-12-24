//
//  UsernameView.swift
//  EmmeQuTiTi
//
//  Created by Francesco Paolo Severino on 24/12/25.
//

import SwiftUI

struct UsernameView: View {
    @State private var showingUsernameAlert = false
    @Binding var username: String
    @State private var editedUsername = ""

    var body: some View {
        Button {
            editedUsername = username
            showingUsernameAlert = true
        } label: {
            Image(systemName: "pencil")
        }
        .alert("Edit Username", isPresented: $showingUsernameAlert) {
            TextField("Username", text: $editedUsername)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                username = editedUsername
            }
            .disabled(editedUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}

#Preview {
    UsernameView(username: .constant("User"))
}

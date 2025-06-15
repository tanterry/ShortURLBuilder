//
//  CredentialFieldView.swift
//  CredentialsManager
//
//  Created by Terry Tan on 15/06/2025.
//

import SwiftUI

struct CredentialFieldView: View {
    let type: CredentialType
    let placeholder: String

    @Binding var value: String

    init(
        type: CredentialType,
        placeholder: String,
        value: Binding<String>
    ) {
        self.type = type
        self.placeholder = placeholder
        _value = value
    }

    var body: some View {
        if !value.isEmpty {
            Text(placeholder)
            deleteButton
        } else {
            SecureField("Enter \(type.displayName)", text: $value)
        }
    }

    private var deleteButton: some View {
        Button(role: .destructive) {
            value = ""
        } label: {
            Text("Delete \(type.displayName)")
        }
    }
}

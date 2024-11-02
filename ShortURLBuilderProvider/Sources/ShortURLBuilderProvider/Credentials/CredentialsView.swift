import SwiftUI

public struct CredentialsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var credentialsManager: CredentialsManager
    @State private var bitlyToken: String = ""
    @State private var cuttlyKey: String = ""
    @State private var hasBitlyToken = false
    @State private var hasCuttlyKey = false

    private let placeholderDots = "••••••••••"

    public init() {}

    public var body: some View {
        NavigationView {
            List {
                Section("Bitly") {
                    CredentialField(
                        type: .bitlyToken,
                        placeholder: placeholderDots,
                        value: $bitlyToken,
                        hasKey: $hasBitlyToken
                    ) { type in
                        credentialsManager.delete(type: type)
                    }
                }
                Section("Cuttly") {
                    CredentialField(
                        type: .cuttlyApiKey,
                        placeholder: placeholderDots,
                        value: $cuttlyKey,
                        hasKey: $hasCuttlyKey
                    ) { type in
                        credentialsManager.delete(type: type)
                    }
                }
            }
            .navigationTitle("API Credentials")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveCredentials()
                    }
                    .disabled(bitlyToken.isEmpty && cuttlyKey.isEmpty)
                }
            }
        }
        .onAppear {
            hasBitlyToken = !credentialsManager.retrieve(for: .bitlyToken).isEmpty
            hasCuttlyKey = !credentialsManager.retrieve(for: .cuttlyApiKey).isEmpty
        }
    }

    private func saveCredentials() {
        if !bitlyToken.isEmpty {
            credentialsManager.save(bitlyToken, for: .bitlyToken)
            hasBitlyToken = true
        }
        if !cuttlyKey.isEmpty {
            credentialsManager.save(cuttlyKey, for: .cuttlyApiKey)
            hasCuttlyKey = true
        }
        dismiss()
    }
}

extension CredentialsView {
    struct CredentialField: View {
        let type: CredentialType
        let placeholder: String

        @Binding var value: String
        @Binding var hasKey: Bool

        var delete: (CredentialType) -> Void

        var body: some View {
            if hasKey {
                Text(placeholder)
                deleteButton
            } else {
                SecureField("Enter \(type.displayName)", text: $value)
            }
        }

        private var deleteButton: some View {
            Button(role: .destructive) {
                hasKey = false
                value = ""
                delete(type)
            } label: {
                Text("Delete \(type.displayName)")
            }
        }
    }
}

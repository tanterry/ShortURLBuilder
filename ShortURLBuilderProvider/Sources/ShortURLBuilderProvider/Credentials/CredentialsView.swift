import SwiftUI

public struct CredentialsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var credentialsManager: CredentialsManager
    @State private var bitlyToken = ""
    @State private var cuttlyKey = ""
    @State private var isModified = false

    private let placeholderDots = "••••••••••"

    public init() {}

    public var body: some View {
        NavigationView {
            List {
                Section("Bitly") {
                    CredentialField(
                        type: .bitlyToken,
                        placeholder: placeholderDots,
                        value: $bitlyToken
                    )
                    .onChange(of: bitlyToken) {
                        isModified = true
                    }
                }
                Section("Cuttly") {
                    CredentialField(
                        type: .cuttlyApiKey,
                        placeholder: placeholderDots,
                        value: $cuttlyKey
                    )
                    .onChange(of: cuttlyKey) {
                        isModified = true
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
                        dismiss()
                    }
                    .disabled(!isModified)
                }
            }
        }
        .onAppear {
            loadCredentials()
        }
    }

    private func loadCredentials() {
        bitlyToken = credentialsManager.retrieve(for: .bitlyToken)
        cuttlyKey = credentialsManager.retrieve(for: .cuttlyApiKey)
    }

    private func saveCredentials() {
        if bitlyToken.isEmpty {
            credentialsManager.delete(type: .bitlyToken)
        } else {
            credentialsManager.save(bitlyToken, for: .bitlyToken)
        }
        if cuttlyKey.isEmpty {
            credentialsManager.delete(type: .cuttlyApiKey)
        } else {
            credentialsManager.save(cuttlyKey, for: .cuttlyApiKey)
        }
    }
}

extension CredentialsView {
    struct CredentialField: View {
        let type: CredentialType
        let placeholder: String

        @Binding var value: String
        @State var isRemovable: Bool

        init(
            type: CredentialType,
            placeholder: String,
            value: Binding<String>
        ) {
            self.type = type
            self.placeholder = placeholder
            _value = value
            isRemovable = !value.wrappedValue.isEmpty
        }

        var body: some View {
            if isRemovable {
                Text(placeholder)
                deleteButton
            } else {
                SecureField("Enter \(type.displayName)", text: $value)
            }
        }

        private var deleteButton: some View {
            Button(role: .destructive) {
                value = ""
                isRemovable = false
            } label: {
                Text("Delete \(type.displayName)")
            }
        }
    }
}

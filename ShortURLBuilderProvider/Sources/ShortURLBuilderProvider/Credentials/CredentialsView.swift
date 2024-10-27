import SwiftUI

public struct CredentialsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var credentialsManager: CredentialsManager
    @State private var bitlyToken: String = ""
    @State private var cuttlyKey: String = ""
    @State private var isEditingBitly = false
    @State private var isEditingCuttly = false
    @State private var hasBitlyToken = false
    @State private var hasCuttlyKey = false
    
    private let placeholderDots = "••••••••••"
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                Section("Bitly") {
                    ZStack(alignment: .leading) {
                        if !isEditingBitly && hasBitlyToken {
                            Text(placeholderDots)
                        }
                        SecureField("Enter Bitly Token", text: $bitlyToken)
                            .opacity(isEditingBitly || !hasBitlyToken ? 1 : 0)
                            .onTapGesture {
                                isEditingBitly = true
                            }
                    }
                    
                    if hasBitlyToken {
                        Button(role: .destructive) {
                            credentialsManager.delete(type: .bitlyToken)
                            bitlyToken = ""
                            isEditingBitly = false
                            hasBitlyToken = false
                        } label: {
                            Text("Delete Bitly Token")
                        }
                    }
                }
                
                Section("Cuttly") {
                    ZStack(alignment: .leading) {
                        if !isEditingCuttly && hasCuttlyKey {
                            Text(placeholderDots)
                        }
                        SecureField("Enter Cuttly API Key", text: $cuttlyKey)
                            .opacity(isEditingCuttly || !hasCuttlyKey ? 1 : 0)
                            .onTapGesture {
                                isEditingCuttly = true
                            }
                    }
                    
                    if hasCuttlyKey {
                        Button(role: .destructive) {
                            credentialsManager.delete(type: .cuttlyApiKey)
                            cuttlyKey = ""
                            isEditingCuttly = false
                            hasCuttlyKey = false
                        } label: {
                            Text("Delete Cuttly API Key")
                        }
                    }
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
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
                }
            }
        }
        .onAppear {
            bitlyToken = credentialsManager.retrieve(for: .bitlyToken)
            cuttlyKey = credentialsManager.retrieve(for: .cuttlyApiKey)
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

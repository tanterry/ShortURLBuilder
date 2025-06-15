import SwiftUI

public struct CredentialsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var credentialsManager: CredentialsManager
    @State private var bitlyToken = ""
    @State private var cuttlyKey = ""
    @State private var isModified = false

    @State private var models: [CredentialFieldViewModel] = []

    @ObservedObject var viewModel = CredentialsViewModel()

    private let placeholderDots = "••••••••••"

    public init() {}

    public var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.fields) { $model in
                    Section(model.name) {
                        CredentialFieldView(
                            type: model.type,
                            placeholder: placeholderDots,
                            value: $model.value
                        )
                        .onChange(of: model.value) {
                            isModified = true
                        }
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
                        viewModel.save()
                        dismiss()
                    }
                    .disabled(!isModified)
                }
            }
        }
    }
}

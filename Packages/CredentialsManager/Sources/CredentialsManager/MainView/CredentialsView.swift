import SwiftUI

public struct CredentialsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isModified = false

    @ObservedObject var viewModel = CredentialsViewModel()

    public init() {}

    public var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.fields) { $model in
                    Section(model.name) {
                        CredentialFieldView(
                            type: model.type,
                            placeholder: model.placeholder,
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

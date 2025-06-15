//
//  CredentialsViewModel.swift
//  CredentialsManager
//
//  Created by Terry Tan on 15/06/2025.
//

import Foundation
import Combine

final class CredentialsViewModel: ObservableObject {
    @Published var fields: [CredentialFieldViewModel]
    private var updatedFields: [CredentialFieldViewModel] = []
    private let credentialsManager = CredentialsManager.shared

    init() {
        fields = [
            CredentialFieldViewModel(
                name: "Bitly",
                type: .bitlyToken,
                value: credentialsManager.retrieve(for: .bitlyToken)
            ),
            CredentialFieldViewModel(
                name: "Cuttly",
                type: .cuttlyApiKey,
                value: credentialsManager.retrieve(for: .cuttlyApiKey)
            )
        ]
    }

    func save() {
        for field in fields {
            if field.value.isEmpty {
                credentialsManager.delete(type: field.type)
            } else {
                credentialsManager.save(field.value, for: field.type)
            }
        }
    }
}

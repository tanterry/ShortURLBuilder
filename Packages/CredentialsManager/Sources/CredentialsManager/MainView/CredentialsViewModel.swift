//
//  CredentialsViewModel.swift
//  CredentialsManager
//
//  Created by Terry Tan on 15/06/2025.
//

import Foundation
import Combine

@MainActor
final class CredentialsViewModel: ObservableObject {
    @Published var fields: [CredentialFieldViewModel]
    private let credentialsManager: CredentialsManager

    init(credentialsManager: CredentialsManager = .shared) {
        self.credentialsManager = credentialsManager
        self.fields = CredentialType.allCases.map { type in
            CredentialFieldViewModel(
                name: type.displayName,
                type: type,
                placeholder: type.placeholder,
                value: credentialsManager.retrieve(for: type)
            )
        }
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

//
//  CredentialFieldViewModel.swift
//  CredentialsManager
//
//  Created by Terry Tan on 15/06/2025.
//

import Foundation
import Combine

final class CredentialFieldViewModel: ObservableObject, Identifiable {
    var id: String { type.rawValue }

    let name: String
    let type: CredentialType
    let placeholder: String

    @Published var value: String

    init(name: String, type: CredentialType, placeholder: String = "••••••••••", value: String) {
        self.name = name
        self.type = type
        self.placeholder = placeholder
        self.value = value
    }
}

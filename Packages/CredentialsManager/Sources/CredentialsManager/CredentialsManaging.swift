import Foundation

@MainActor
public protocol CredentialsManaging: ObservableObject, Sendable {
    var lastUpdated: Date { get }
    func save(_ value: String, for type: CredentialType)
    func retrieve(for type: CredentialType) -> String
    func delete(type: CredentialType)
    func hasCredential(for type: CredentialType) -> Bool
}

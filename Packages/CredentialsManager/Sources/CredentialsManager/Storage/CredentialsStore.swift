import Foundation

public protocol CredentialsStore: Sendable {
    func save(_ value: String, for key: String) -> Bool
    func retrieve(for key: String) -> String?
    func delete(for key: String) -> Bool
}

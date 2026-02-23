import Foundation

@MainActor
public final class CredentialsManager: CredentialsManaging {
    public static let shared = CredentialsManager()

    @Published public private(set) var lastUpdated = Date()

    private let store: CredentialsStore

    public init(store: CredentialsStore = KeychainCredentialsStore()) {
        self.store = store
    }

    public func save(_ value: String, for type: CredentialType) {
        guard !value.isEmpty else { return }

        if store.save(value, for: type.rawValue) {
            lastUpdated = Date()
        }
    }

    public func retrieve(for type: CredentialType) -> String {
        store.retrieve(for: type.rawValue) ?? ""
    }

    public func delete(type: CredentialType) {
        if store.delete(for: type.rawValue) {
            lastUpdated = Date()
        }
    }

    public func hasCredential(for type: CredentialType) -> Bool {
        !retrieve(for: type).isEmpty
    }

}

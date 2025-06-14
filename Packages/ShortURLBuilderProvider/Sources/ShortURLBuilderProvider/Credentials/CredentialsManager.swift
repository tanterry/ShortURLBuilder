import Foundation

public enum CredentialType: String, CaseIterable {
    case bitlyToken = "BitlyAPIToken"
    case cuttlyApiKey = "CuttlyApiToken"

    public var displayName: String {
        switch self {
        case .bitlyToken:
            return "Bitly API Token"
        case .cuttlyApiKey:
            return "Cuttly API Token"
        }
    }
}

@MainActor
public final class CredentialsManager: ObservableObject {
    public static let shared = CredentialsManager()
    private init() {}

    public func save(_ value: String, for type: CredentialType) {
        guard !value.isEmpty else { return }
        _ = KeychainService.save(value, forKey: type.rawValue)
    }

    public func retrieve(for type: CredentialType) -> String {
        KeychainService.retrieve(forKey: type.rawValue) ?? ""
    }

    public func delete(type: CredentialType) {
        _ = KeychainService.delete(forKey: type.rawValue)
    }

}

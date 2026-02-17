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

    public var placeholder: String { "••••••••••" }
}

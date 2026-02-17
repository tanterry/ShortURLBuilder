public enum Config {
    // static let appGroup = "group.shortUrlDev.app.identifier"
    public static let store: CredentialsStore = KeychainCredentialsStore()
    
    public static var bitlyToken: String {
        store.retrieve(for: CredentialType.bitlyToken.rawValue) ?? ""
    }

    public static var cuttlyApiKey: String {
        store.retrieve(for: CredentialType.cuttlyApiKey.rawValue) ?? ""
    }

    static func saveBitlyToken(_ token: String) {
        _ = store.save(token, for: CredentialType.bitlyToken.rawValue)
    }

    static func saveCuttlyKey(_ key: String) {
        _ = store.save(key, for: CredentialType.cuttlyApiKey.rawValue)
    }
}

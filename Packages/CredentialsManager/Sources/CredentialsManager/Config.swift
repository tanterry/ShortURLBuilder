public enum Config {
    // static let appGroup = "group.shortUrlDev.app.identifier"
    
    public static var bitlyToken: String {
        KeychainService.retrieve(forKey: CredentialType.bitlyToken.rawValue) ?? ""
    }

    public static var cuttlyApiKey: String {
        KeychainService.retrieve(forKey: CredentialType.cuttlyApiKey.rawValue) ?? ""
    }

    static func saveBitlyToken(_ token: String) {
        _ = KeychainService.save(token, forKey: CredentialType.bitlyToken.rawValue)
    }

    static func saveCuttlyKey(_ key: String) {
        _ = KeychainService.save(key, forKey: CredentialType.cuttlyApiKey.rawValue)
    }
}

import Foundation
import Security

enum KeychainService {
    static func save(_ value: String, forKey key: String) -> Bool {
        print("🔑 Saving to Keychain - Key: \(key)")
        guard let data = value.data(using: .utf8) else {
            print("❌ Failed to convert value to data")
            return false
        }

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data,
//            kSecAttrAccessGroup: Config.appGroup,
        ]

        // First try to delete any existing value
        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        let success = status == errSecSuccess
        print("🔑 Save status: \(success ? "Success ✅" : "Failed ❌") - Status: \(status)")
        return success
    }

    static func retrieve(forKey key: String) -> String? {
        print("🔍 Retrieving from Keychain - Key: \(key)")
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
//            kSecAttrAccessGroup: Config.appGroup,
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else {
            print("❌ Retrieval failed with status: \(status)")
            return nil
        }
        if let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            print("✅ Retrieved value successfully (length: \(value.count))")
            return value
        }
        print("❌ Failed to convert data to string")
        return nil
    }

    static func delete(forKey key: String) -> Bool {
        print("🗑 Deleting from Keychain - Key: \(key)")
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
//            kSecAttrAccessGroup: Config.appGroup,
        ]

        let status = SecItemDelete(query as CFDictionary)
        let success = status == errSecSuccess
        print("🗑 Delete status: \(success ? "Success ✅" : "Failed ❌") - Status: \(status)")
        return success
    }
}

import Foundation
import Security

public struct KeychainCredentialsStore: CredentialsStore {
    public init() {}

    public func save(_ value: String, for key: String) -> Bool {
        guard let data = value.data(using: .utf8) else {
            return false
        }

        let query = baseQuery(for: key, includeData: true, data: data)

        // Delete existing value first to avoid duplicates.
        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    public func retrieve(for key: String) -> String? {
        let query = baseQuery(for: key, includeData: true, data: nil)
            .merging([kSecReturnData: true, kSecMatchLimit: kSecMatchLimitOne]) { $1 }

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            return nil
        }

        if let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        }
        return nil
    }

    public func delete(for key: String) -> Bool {
        let query = baseQuery(for: key, includeData: false, data: nil)
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }

    private func baseQuery(for key: String, includeData: Bool, data: Data?) -> [CFString: Any] {
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
            // kSecAttrAccessGroup: Config.appGroup,
        ]

        if includeData, let data {
            query[kSecValueData] = data
        }
        return query
    }
}

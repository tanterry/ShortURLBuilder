import Foundation
import Testing
@testable import CredentialsManager

private final class InMemoryCredentialsStore: @unchecked Sendable, CredentialsStore {
    private var storage: [String: String] = [:]
    private let lock = NSLock()

    func save(_ value: String, for key: String) -> Bool {
        lock.lock()
        storage[key] = value
        lock.unlock()
        return true
    }

    func retrieve(for key: String) -> String? {
        lock.lock()
        let value = storage[key]
        lock.unlock()
        return value
    }

    func delete(for key: String) -> Bool {
        lock.lock()
        storage[key] = nil
        lock.unlock()
        return true
    }
}

@Test func credentialsManagerUsesInjectedStore() async throws {
    let store = InMemoryCredentialsStore()
    let manager = await CredentialsManager(store: store)
    await manager.save("abc", for: .bitlyToken)
    let value = await manager.retrieve(for: .bitlyToken)
    #expect(value == "abc")
}

@Test func credentialsManagerDeletesValue() async throws {
    let store = InMemoryCredentialsStore()
    let manager = await CredentialsManager(store: store)
    await manager.save("abc", for: .bitlyToken)
    await manager.delete(type: .bitlyToken)
    let value = await manager.retrieve(for: .bitlyToken)
    #expect(value.isEmpty)
}

@Test func credentialsManagerDoesNotSaveEmptyValue() async throws {
    let store = InMemoryCredentialsStore()
    let manager = await CredentialsManager(store: store)
    await manager.save("", for: .bitlyToken)
    let value = await manager.retrieve(for: .bitlyToken)
    #expect(value.isEmpty)
}

@Test func configUsesInjectedStore() async throws {
    let store = InMemoryCredentialsStore()
    _ = store.save("token", for: CredentialType.bitlyToken.rawValue)
    Config.store = store
    #expect(Config.bitlyToken == "token")
}
}

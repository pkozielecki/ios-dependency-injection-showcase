//
//  LiveLocalStorage.swift
//  iOS Dependency Injection Showcase
//

import Common
import Foundation

/// A concrete implementation of the `LocalStorage` protocol that uses `UserDefaults` to manage data storage.
public final class LiveLocalStorage: @unchecked Sendable, LocalStorage {
    /// The `UserDefaultsWrapper` instance for interacting with `UserDefaults`.
    private let userDefaults: UserDefaultsWrapper

    /// Initializes a new instance of `LiveLocalStorage`.
    /// - Parameter userDefaults: A wrapper for `UserDefaults` to handle data storage operations.
    public init(
        userDefaults: UserDefaultsWrapper = UserDefaults.standard
    ) {
        self.userDefaults = userDefaults
    }

    #warning("DI-007 - Add CRUD unit tests for storage.")

    /// - SeeAlso: `LocalStorage.save(items:key:)`
    public func save(_ items: some Encodable, forKey key: String) throws {
        let data = try JSONEncoder().encode(items)
        userDefaults.set(data, forKey: key)
    }

    /// - SeeAlso: `LocalStorage.load(key:)`
    public func load<T: Decodable>(forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    /// - SeeAlso: `LocalStorage.remove(items:key:)`
    public func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

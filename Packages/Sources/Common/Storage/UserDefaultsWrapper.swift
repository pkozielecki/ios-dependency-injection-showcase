//
//  UserDefaultsWrapper.swift
//  iOS Dependency Injection Showcase
//

import Foundation

/// A protocol for interacting with `UserDefaults`, providing methods to store, retrieve, and remove data.
public protocol UserDefaultsWrapper {
    /// Sets a value in `UserDefaults` for the given key.
    /// - Parameters:
    ///   - value: The value to store. Use `nil` to remove the value for the key.
    ///   - defaultName: The key under which the value is stored.
    func set(_ value: Any?, forKey defaultName: String)

    /// Retrieves data from `UserDefaults` for the given key.
    /// - Parameter defaultName: The key associated with the data.
    /// - Returns: The data stored under the key, or `nil` if no data exists.
    func data(forKey defaultName: String) -> Data?

    /// Removes the value associated with the given key from `UserDefaults`.
    /// - Parameter defaultName: The key of the value to remove.
    func removeObject(forKey defaultName: String)
}

/// Ensuring `UserDefaults` conform to the wrapper.
extension UserDefaults: UserDefaultsWrapper {}

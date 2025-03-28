//
//  LocalStorage.swift
//  iOS Dependency Injection Showcase
//

import Foundation

/// A protocol for managing local storage operations, including saving, loading, and removing data.
public protocol LocalStorage: Sendable {
    /// Saves an encodable item to local storage for the given key.
    /// - Parameters:
    ///   - items: The item to save.
    ///   - key: The key associated with the item.
    /// - Throws: An error if the saving process fails.
    func save<T: Encodable>(_ items: T, forKey key: String) throws

    /// Loads a decodable item from local storage for the given key.
    /// - Parameter key: The key associated with the item.
    /// - Returns: The decoded item, or `nil` if no item is found.
    /// - Throws: An error if the loading process fails.
    func load<T: Decodable>(forKey key: String) throws -> T?

    /// Removes the item associated with the given key from local storage.
    /// - Parameter key: The key of the item to remove.
    func remove(forKey key: String)
}

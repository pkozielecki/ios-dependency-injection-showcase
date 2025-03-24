//
//  UserDefaultsFactory.swift
//  iOS Dependency Injection Showcase
//

import Foundation

/// A factory for creating `UserDefaults` instances with an optional suite name.
enum UserDefaultsFactory {
    /// Creates a `UserDefaults` instance for the specified suite name.
    /// - Parameter suiteName: The name of the suite. Defaults to `"DIShowcase"`.
    /// - Returns: A `UserDefaults` instance configured with the given suite name, or the standard `UserDefaults` instance if the suite name is invalid.
    static func make(suiteName: String = "DIShowcase") -> UserDefaults {
        UserDefaults(suiteName: suiteName) ?? .standard
    }
}

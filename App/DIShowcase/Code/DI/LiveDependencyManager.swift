//
//  LiveDependencyManager.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import Foundation

/// A dependency manager for registering and managing dependencies at runtime.
/// Operates on the main actor to ensure thread safety.
@MainActor
final class LiveDependencyManager {
    private var dependencies: [String: Any] = [:]

    /// Registers a dependency for a given type.
    /// - Parameters:
    ///   - dependency: The instance of the dependency to register.
    ///   - type: The type of the dependency being registered.
    func register<T>(_ dependency: T, for type: T.Type) {
        let id = String(describing: type)
        dependencies[id] = dependency
    }
}

// MARK: - `DependencyProvider`

extension LiveDependencyManager: DependencyProvider {
    public func resolve<T>() -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            fatalError("No dependency found for \(id)! You have to register that dependency first!")
        }
    }
}

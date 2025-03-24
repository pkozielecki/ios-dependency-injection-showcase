//
//  DependencyProvider.swift
//  iOS Dependency Injection Showcase
//

import Common
import Foundation

/// A protocol defining an abstraction resolving dependencies in the application.
@MainActor public protocol DependencyProvider: AnyObject, Sendable {
    /// Resolves a dependency of the specified type.
    /// - Returns: An instance of the requested type `T`.
    func resolve<T>() -> T
}

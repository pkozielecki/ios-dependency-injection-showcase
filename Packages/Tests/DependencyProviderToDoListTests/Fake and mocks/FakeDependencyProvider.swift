//
//  FakeDependencyProvider.swift
//  iOS Dependency Injection Showcase
//

@testable import DependencyProviderToDoList
import Foundation

final class FakeDependencyProvider: DependencyProvider {
    public var simulatedDependencies: [String: Any]?

    func resolve<T>() -> T {
        let id = String(describing: T.self)
        if let dependency = simulatedDependencies?[id] as? T {
            return dependency
        } else {
            fatalError("No dependency found for \(id)! You have to register that dependency first!")
        }
    }
}

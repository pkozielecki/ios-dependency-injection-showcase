//
//  ThirdPartyDIToDoListFactory.swift
//  iOS Dependency Injection Showcase
//

import Common
import CommonUI
import Foundation
import SwiftUI
import Swinject

/// A factory for creating a TodoListView using a third-party dependency injection container.
@MainActor public enum ThirdPartyDIToDoListFactory {
    /// Creates and returns a configured TodoListView.
    /// - Parameter dependencyContainer: The dependency injection container used to resolve dependencies.
    /// - Returns: A `TodoListView`.
    @ViewBuilder
    public static func make(
        dependencyContainer: Container
    ) -> TodoListView {
        TodoListView(
            viewModel: LiveTodoListViewModel(
                storageService: dependencyContainer.resolve(LocalStorage.self)!,
                title: "3rd party DI lib"
            )
        )
    }
}

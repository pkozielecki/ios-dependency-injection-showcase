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
    /// - Returns: A TodoListView with its ViewModel and dependencies properly configured.
    @ViewBuilder
    public static func make(
        dependencyContainer: Container
    ) -> some View {
        TodoListView(
            viewModel: LiveTodoListViewModel(
                storageService: dependencyContainer.resolve(LocalStorage.self)!,
                title: "3rd party DI lib"
            )
        )
    }
}

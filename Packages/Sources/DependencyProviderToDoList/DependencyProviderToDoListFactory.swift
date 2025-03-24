//
//  DependencyProviderToDoListFactory.swift
//  iOS Dependency Injection Showcase
//

import Common
import CommonUI
import Foundation
import SwiftUI

/// A factory for creating to-do list views using a dependency provider.
@MainActor
public enum DependencyProviderToDoListFactory {
    /// Creates a `TodoListView` to be used in the main app.
    /// - Parameter dependencyProvider: The `DependencyProvider` used to resolve required dependencies.
    /// - Returns: A `TodoListView`.
    @ViewBuilder
    public static func make(
        dependencyProvider: DependencyProvider
    ) -> some View {
        TodoListView(
            viewModel: LiveTodoListViewModel(
                storageService: dependencyProvider.resolve(),
                title: "Dependency Provider"
            )
        )
    }
}

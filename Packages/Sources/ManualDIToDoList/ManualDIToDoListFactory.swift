//
//  ManualDIToDoListFactory.swift
//  iOS Dependency Injection Showcase
//

import Common
import CommonUI
import Foundation
import SwiftUI

/// A factory for creating to-do list views using manual dependency injection.
@MainActor
public enum ManualDIToDoListFactory {
    /// Creates a `TodoListView` to be used in the main app.
    /// - Parameter storage: The `LocalStorage` instance to be injected into the view model.
    /// - Returns: A `TodoListView`.
    @ViewBuilder
    public static func make(
        storage: LocalStorage
    ) -> TodoListView {
        TodoListView(
            viewModel: LiveTodoListViewModel(
                storageService: storage,
                title: "Manual DI"
            )
        )
    }
}

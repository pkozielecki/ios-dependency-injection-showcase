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
    /// Creates a `TodoListView` with a manually injected view model.
    /// - Parameter storage: The `LocalStorage` instance to be injected into the view model.
    /// - Returns: A `TodoListView` configured with a manually injected view model.
    @ViewBuilder
    public static func make(
        storage: LocalStorage
    ) -> some View {
        TodoListView(
            viewModel: ManualInjectionTodoListViewModel(
                storageService: storage
            )
        )
    }
}

//
//  ManualInjectionTodoListViewModel.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import Foundation
import Observation
import SwiftUI

/// A concrete implementation of `TodoListViewModel` using manual dependency injection.
@Observable final class ManualInjectionTodoListViewModel: TodoListViewModel {
    /// - SeeAlso: `TodoListViewModel.storageService`
    let storageService: LocalStorage

    /// - SeeAlso: `TodoListViewModel.todoItems`
    var todoItems: [TodoItem] = []

    /// - SeeAlso: `TodoListViewModel.errorMessage`
    var errorMessage: String?

    /// Initializes a new instance of `ManualInjectionTodoListViewModel` with the provided storage service.
    /// - Parameter storageService: The `LocalStorage` instance used for managing persistent to-do items.
    init(storageService: LocalStorage) {
        self.storageService = storageService
        load()
    }
}

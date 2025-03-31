//
//  LiveTodoListViewModel.swift
//  iOS Dependency Injection Showcase
//

import Foundation
import Observation

/// A concrete implementation of the `TodoListViewModel` protocol.
/// Conforms to `@Observable` for state management and provides functionalities for managing a to-do list.
@Observable public final class LiveTodoListViewModel: TodoListViewModel {
    /// - SeeAlso: `TodoListViewModel.storageService`
    public let storageService: LocalStorage

    /// - SeeAlso: `TodoListViewModel.todoItems`
    public var todoItems: [TodoItem] = []

    /// - SeeAlso: `TodoListViewModel.errorMessage`
    public var errorMessage: String?

    /// - SeeAlso: `TodoListViewModel.title`
    public var title: String

    /// Initializes a new instance of `LiveTodoListViewModel`.
    /// - Parameters:
    ///   - storageService: The `LocalStorage` instance used for managing persistent to-do items.
    ///   - title: The title of the to-do list view.
    public init(
        storageService: LocalStorage,
        title: String
    ) {
        self.storageService = storageService
        self.title = title
    }

    /// - SeeAlso: `TodoListViewModel.load()`
    public func load() {
        do {
            if let loadedTodos: [TodoItem] = try storageService.load(forKey: storageKey) {
                todoItems = loadedTodos
            }
        } catch {
            errorMessage = "Failed to load todos: \(error.localizedDescription)"
        }
    }

    /// - SeeAlso: `TodoListViewModel.add(todo:)`
    public func add(todo: TodoItem) {
        guard !todo.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        todoItems.append(todo)
        save()
    }

    /// - SeeAlso: `TodoListViewModel.update(todo:)`
    public func update(todo: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index] = todo
            save()
        }
    }

    /// - SeeAlso: `TodoListViewModel.toggleCompletion(todo:)`
    public func toggleCompletion(for todo: TodoItem) {
        var updatedTodo = todo
        updatedTodo.isCompleted.toggle()
        update(todo: updatedTodo)
    }

    /// - SeeAlso: `TodoListViewModel.delete(todo:)`
    public func delete(todo: TodoItem) {
        todoItems.removeAll { $0.id == todo.id }
        save()
    }
}

private extension LiveTodoListViewModel {
    var storageKey: String {
        StorageKeys.todoList.rawValue
    }

    func save() {
        do {
            try storageService.save(todoItems, forKey: storageKey)
        } catch {
            errorMessage = "Failed to save todos: \(error.localizedDescription)"
        }
    }
}

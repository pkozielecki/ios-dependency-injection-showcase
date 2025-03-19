//
//  TodoListViewModel.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import Foundation
import Observation
import SwiftUI

/// A protocol defining the interface for a to-do list view model.
public protocol TodoListViewModel: Observable, AnyObject {
    /// The storage service used for managing persistent to-do items.
    var storageService: LocalStorage { get }

    /// The list of to-do items.
    /// Important: Made writable only to allow operating on it in the protocol extension.
    var todoItems: [TodoItem] { get set }

    /// An optional error message for handling and displaying errors.
    /// Important: Made writable only to allow operating on it in the protocol extension.
    var errorMessage: String? { get set }

    /// Loads the to-do items from storage.
    func load()

    /// Saves the current to-do items to storage.
    func save()

    /// Adds a new to-do item to the list.
    /// - Parameter todo: The `TodoItem` to add.
    func add(todo: TodoItem)

    /// Updates an existing to-do item.
    /// - Parameter todo: The updated `TodoItem`.
    func update(todo: TodoItem)

    /// Toggles the completion status of a to-do item.
    /// - Parameter todo: The `TodoItem` to toggle.
    func toggleCompletion(for todo: TodoItem)

    /// Deletes a to-do item from the list.
    /// - Parameter todo: The `TodoItem` to delete.
    func delete(todo: TodoItem)
}

public extension TodoListViewModel {
    #warning("DI-005 - Add tests for code in the extension.")
    func load() {
        do {
            if let loadedTodos: [TodoItem] = try storageService.load(forKey: storageKey) {
                todoItems = loadedTodos
            }
        } catch {
            errorMessage = "Failed to load todos: \(error.localizedDescription)"
        }
    }

    func save() {
        do {
            try storageService.save(todoItems, forKey: storageKey)
        } catch {
            errorMessage = "Failed to save todos: \(error.localizedDescription)"
        }
    }

    func add(todo: TodoItem) {
        guard !todo.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        todoItems.append(todo)
        save()
    }

    func update(todo: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index] = todo
            save()
        }
    }

    func toggleCompletion(for todo: TodoItem) {
        var updatedTodo = todo
        updatedTodo.isCompleted.toggle()
        update(todo: updatedTodo)
    }

    func delete(todo: TodoItem) {
        todoItems.removeAll { $0.id == todo.id }
        save()
    }
}

private extension TodoListViewModel {
    var storageKey: String {
        StorageKeys.todoList.rawValue
    }
}

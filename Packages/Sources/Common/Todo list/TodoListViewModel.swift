//
//  TodoListViewModel.swift
//  iOS Dependency Injection Showcase
//

import Foundation
import Observation
import SwiftUI

/// A protocol defining the interface for a to-do list view model.
public protocol TodoListViewModel: Observable, AnyObject {
    /// The title of the view.
    var title: String { get }

    /// The list of to-do items.
    var todoItems: [TodoItem] { get }

    /// An optional error message for handling and displaying errors.
    var errorMessage: String? { get set }

    /// Loads the to-do items from storage.
    func load()

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

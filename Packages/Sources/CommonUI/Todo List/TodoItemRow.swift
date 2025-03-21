//
//  TodoItemRow.swift
//  iOS Dependency Injection Showcase
//

import Common
import SwiftUI

/// A view representing a single row in a to-do list.
public struct TodoItemRow: View {
    /// The to-do item displayed in the row.
    public let todo: TodoItem

    /// The action to perform when the to-do item's completion status is toggled.
    public let onToggle: () -> Void

    /// The action to perform when the to-do item is edited.
    public let onEdit: () -> Void

    /// The action to perform when the to-do item is deleted.
    public let onDelete: () -> Void

    /// Initializes a new instance of the TodoItemRow.
    /// - Parameters:
    ///   - todo: The TodoItem to be displayed and managed by this row.
    ///   - onToggle: A closure to be called when the completion status of the todo item is toggled.
    ///   - onEdit: A closure to be called when the user requests to edit the todo item.
    ///   - onDelete: A closure to be called when the user requests to delete the todo item.
    public init(
        todo: TodoItem,
        onToggle: @escaping () -> Void,
        onEdit: @escaping () -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.todo = todo
        self.onToggle = onToggle
        self.onEdit = onEdit
        self.onDelete = onDelete
    }

    public var body: some View {
        HStack {
            buttonToggle
            labelTitle
            Spacer()
            buttonEdit
            buttonDelete
        }
        .padding(.vertical, 8)
    }
}

private extension TodoItemRow {
    #warning("DI-006 - Extract toggle button to CommonUI.")
    var buttonToggle: some View {
        Button(action: onToggle) {
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isCompleted ? .green : .gray)
        }
        .buttonStyle(BorderlessButtonStyle())
        .accessibilityLabel(todo.isCompleted ? "Mark as incomplete" : "Mark as complete")
    }

    #warning("DI-006 - Extract edit button to CommonUI.")
    var buttonEdit: some View {
        Button(action: onEdit) {
            Image(systemName: "pencil")
                .foregroundColor(.blue)
        }
        .buttonStyle(BorderlessButtonStyle())
        .allowsHitTesting(true)
        .accessibilityLabel("Edit todo")
    }

    #warning("DI-006 - Extract delete button to CommonUI.")
    var buttonDelete: some View {
        Button(action: onDelete) {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .buttonStyle(BorderlessButtonStyle())
        .accessibilityLabel("Delete todo")
    }

    var labelTitle: some View {
        Text(todo.title)
            .strikethrough(todo.isCompleted)
            .foregroundColor(todo.isCompleted ? .gray : .primary)
    }
}

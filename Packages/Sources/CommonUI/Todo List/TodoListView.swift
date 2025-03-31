//
//  TodoListView.swift
//  iOS Dependency Injection Showcase
//

import Common
import Inject
import SwiftUI

/// A view for displaying and managing a to-do list.
public struct TodoListView: View {
    /// The view model providing data and actions for the to-do list.
    let viewModel: TodoListViewModel

    @ObserveInjection private var inject
    @State private var newTodoTitle = ""
    @State private var editingTodo: TodoItem?
    @State private var editedTitle = ""

    #warning("DI-005 - Add interactions tests for view.")
    #warning("DI-006 - Extract alert to CommonUI.")

    /// Initializes a new instance of the TodoListView.
    /// - Parameters:
    ///   - viewModel: The view model of the TodoListView.
    public init(
        viewModel: TodoListViewModel
    ) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            VStack {
                addItemSection
                itemsSection
            }
            .padding(.top, 20)
            .navigationTitle(viewModel.title)
            .sheet(item: $editingTodo) {
                makeEditItemView(todo: $0)
            }
            .alert(
                "Error",
                isPresented: .init(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                ),
                actions: { Button("OK") { viewModel.errorMessage = nil } },
                message: { Text(viewModel.errorMessage ?? "") }
            )
            .task {
                viewModel.load()
            }
        }
        .enableInjection()
    }
}

private extension TodoListView {
    /// The section for adding a new to-do item.
    var addItemSection: some View {
        HStack {
            TextField("Add a new todo", text: $newTodoTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("New todo input field")

            Button(action: {
                viewModel.add(todo: .init(title: newTodoTitle))
                newTodoTitle = ""
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
            .disabled(newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(!newTodoTitle.isEmpty ? 1 : 0.5)
            .accessibilityLabel("Add todo")
        }
        .padding(.horizontal)
    }

    /// The section displaying the list of to-do items.
    var itemsSection: some View {
        List {
            ForEach(viewModel.todoItems) { todo in
                TodoItemRow(
                    todo: todo,
                    onToggle: {
                        viewModel.toggleCompletion(for: todo)
                    },
                    onEdit: {
                        editingTodo = todo
                        editedTitle = todo.title
                    },
                    onDelete: {
                        viewModel.delete(todo: todo)
                    }
                )
            }
        }
        .listStyle(InsetGroupedListStyle())
    }

    /// Creates the view for editing an existing to-do item.
    @ViewBuilder
    func makeEditItemView(todo: TodoItem) -> some View {
        EditTodoView(
            title: $editedTitle,
            onSave: {
                var updatedTodo = todo
                updatedTodo.title = editedTitle
                viewModel.update(todo: updatedTodo)
                editingTodo = nil
            },
            onCancel: {
                editingTodo = nil
            }
        )
    }
}

//
//  FakeTodoListViewModel.swift
//  iOS Dependency Injection Showcase
//

import Common
import CommonUI

public class FakeTodoListViewModel: TodoListViewModel {
    public var errorMessage: String?

    public var title: String {
        simulatedTitle ?? ""
    }

    public var todoItems: [TodoItem] {
        simulatedToDoItems ?? []
    }

    public var simulatedTitle: String?
    public var simulatedToDoItems: [TodoItem]?

    public init() {}

    #warning("DI-005 - Record interaction for tests.")
    public func load() {}
    public func add(todo: TodoItem) {}
    public func update(todo: TodoItem) {}
    public func toggleCompletion(for todo: TodoItem) {}
    public func delete(todo: TodoItem) {}
}

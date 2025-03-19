//
//  TodoItem.swift
//  iOS Dependency Injection Showcase
//

import Foundation

/// A struct representing a simple to-do item.
public struct TodoItem: Identifiable, Codable, Hashable {
    /// The unique identifier for the to-do item.
    public let id: UUID

    /// The title or description of the to-do item.
    public var title: String

    /// A boolean indicating whether the to-do item is completed.
    public var isCompleted: Bool

    /// Initializes a new instance of `TodoItem`.
    /// - Parameters:
    ///   - id: The unique identifier for the to-do item. Defaults to a new UUID.
    ///   - title: The title or description of the to-do item.
    ///   - isCompleted: A boolean indicating whether the item is completed. Defaults to `false`.
    public init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

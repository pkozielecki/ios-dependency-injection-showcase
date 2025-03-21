//
//  EditTodoView.swift
//  iOS Dependency Injection Showcase
//

import Common
import SwiftUI

/// A view for editing the title of a to-do item.
public struct EditTodoView: View {
    /// A binding to the title of the to-do item being edited.
    @Binding
    public var title: String

    /// The action to perform when the save button is tapped.
    public let onSave: () -> Void

    /// The action to perform when the cancel button is tapped.
    public let onCancel: () -> Void

    /// Initializes a new instance of the EditTodoView.
    /// - Parameters:
    ///   - title: A binding to the title string that will be edited.
    ///   - onSave: A closure that will be called when the user taps the Save button.
    ///   - onCancel: A closure that will be called when the user taps the Cancel button.
    public init(
        title: Binding<String>,
        onSave: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        _title = title
        self.onSave = onSave
        self.onCancel = onCancel
    }

    public var body: some View {
        NavigationStack {
            todoEditSection
                .navigationTitle("Edit Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: onCancel)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: onSave)
                            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
        }
    }
}

private extension EditTodoView {
    var todoEditSection: some View {
        VStack {
            TextField("Todo title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityLabel("Edit todo title")
            Spacer()
        }
    }
}

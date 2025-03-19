//
//  EditTodoView.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import SwiftUI

/// A view for editing the title of a to-do item.
struct EditTodoView: View {
    /// A binding to the title of the to-do item being edited.
    @Binding var title: String

    /// The action to perform when the save button is tapped.
    let onSave: () -> Void

    /// The action to perform when the cancel button is tapped.
    let onCancel: () -> Void

    var body: some View {
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

//
//  View+AnyView.swift
//  iOS Dependency Injection Showcase
//

import SwiftUI

public extension View {
    /// Wraps the current view in an `AnyView`.
    /// - Returns: An `AnyView` instance containing the current view.
    var anyView: AnyView {
        AnyView(self)
    }
}

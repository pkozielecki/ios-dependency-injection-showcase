//
//  DIShowcaseApp.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import Foundation
import SwiftUI

@main
struct DIShowcaseApp: App {
    var body: some Scene {
        WindowGroup {
            manualDIToDoListView
        }
    }
}

private extension DIShowcaseApp {
    @MainActor
    var manualDIToDoListView: some View {
        ManualDIToDoListFactory.make(
            storage: LiveLocalStorage(
                userDefaults: UserDefaults(suiteName: "DIShowcase") ?? .standard
            )
        )
    }
}

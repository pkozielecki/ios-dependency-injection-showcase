//
//  DIShowcaseApp.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import SwiftUI

@main
struct DIShowcaseApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView(
                viewModel: ManualInjectionTodoListViewModel(
                    storageService: LiveLocalStorage(
                        userDefaults: UserDefaults(suiteName: "DIShowcase") ?? .standard
                    )
                )
            )
        }
    }
}

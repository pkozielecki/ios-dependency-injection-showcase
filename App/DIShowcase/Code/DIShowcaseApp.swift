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
            TabView {
                manualDIToDoListView
                    .tabItem {
                        Label(
                            "Manual DI",
                            systemImage: "hammer"
                        )
                    }

                dependencyProviderToDoListView
                    .tabItem {
                        Label(
                            "Dep. Provider",
                            systemImage: "syringe.fill"
                        )
                    }

                #warning("DI-010 - Add 3rd party DI implementation")
            }
        }
    }
}

// MARK: - View factories:

private extension DIShowcaseApp {
    @MainActor
    var manualDIToDoListView: some View {
        ManualDIToDoListFactory.make(
            storage: LiveLocalStorage(
                userDefaults: UserDefaultsFactory.make()
            )
        )
    }

    @MainActor
    var dependencyProviderToDoListView: some View {
        let dependencyProvider = makeDependencyProvider()
        return DependencyProviderToDoListFactory.make(
            dependencyProvider: dependencyProvider
        )
    }
}

// MARK: - Implementation details:

private extension DIShowcaseApp {
    #warning("DI-008 - Extract dependencies creation to a separate factory")

    @MainActor
    func makeDependencyProvider() -> DependencyProvider {
        let dependencyManager = LiveDependencyManager()
        let userDefaults = UserDefaultsFactory.make()
        let storage = LiveLocalStorage(userDefaults: userDefaults)
        dependencyManager.register(storage, for: LocalStorage.self)
        return dependencyManager
    }
}

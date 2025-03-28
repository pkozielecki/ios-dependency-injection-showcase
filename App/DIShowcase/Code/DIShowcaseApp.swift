//
//  DIShowcaseApp.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import Foundation
import SwiftUI
import Swinject

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

                thirdPartyDIDoListView
                    .tabItem {
                        Label(
                            "3rd party DI",
                            systemImage: "3.circle.fill"
                        )
                    }
            }
        }
    }
}

// MARK: - View factories:

private extension DIShowcaseApp {
    @MainActor
    var manualDIToDoListView: some View {
        ManualDIToDoListFactory.make(storage: makeStorage())
    }

    @MainActor
    var dependencyProviderToDoListView: some View {
        let dependencyProvider = makeDependencyProvider()
        return DependencyProviderToDoListFactory.make(
            dependencyProvider: dependencyProvider
        )
    }

    @MainActor
    var thirdPartyDIDoListView: some View {
        let dependencyContainer = makeSwinjectDependencyContainer()
        return ThirdPartyDIToDoListFactory.make(
            dependencyContainer: dependencyContainer
        )
    }
}

// MARK: - Implementation details:

private extension DIShowcaseApp {
    #warning("DI-008 - Extract dependencies creation to a separate factory")

    @MainActor
    func makeDependencyProvider() -> DependencyProvider {
        let dependencyManager = LiveDependencyManager()
        let storage = makeStorage()
        dependencyManager.register(storage, for: LocalStorage.self)
        return dependencyManager
    }

    @MainActor
    func makeSwinjectDependencyContainer() -> Container {
        let container = Container()
        let storage = makeStorage()
        container.register(LocalStorage.self) { _ in storage }
        return container
    }

    func makeStorage() -> LocalStorage {
        let userDefaults = UserDefaultsFactory.make()
        let storage = LiveLocalStorage(userDefaults: userDefaults)
        return storage
    }
}

//
//  DIShowcaseApp.swift
//  iOS Dependency Injection Showcase
//

import Common
import DIShowcasePackage
import SwiftUI
import Swinject

/// Main entry point into the app - decides to run main app or test app.
@main struct AppEntryPoint {
    static func main() {
        guard !isRunningTests() else {
            TestApp.main()
            return
        }

        DIShowcaseApp.main()
    }

    private static func isRunningTests() -> Bool {
        NSClassFromString("XCTestCase") != nil
    }
}

/// Main app.
struct DIShowcaseApp: App {
    @State private var dependencyProvider = makeDependencyProvider()
    @State private var dependencyContainer = makeSwinjectDependencyContainer()
    @State private var localStorage = makeStorage()

    var body: some Scene {
        WindowGroup {
            MainAppView(
                dependencyProvider: dependencyProvider,
                dependencyContainer: dependencyContainer,
                localStorage: localStorage
            )
        }
    }
}

/// Test app placeholder.
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Running tests...")
                .font(.largeTitle)
        }
    }
}

// MARK: - Implementation details:

private extension DIShowcaseApp {
    #warning("DI-008 - Extract dependencies creation to a separate factory")

    @MainActor
    static func makeDependencyProvider() -> DependencyProvider {
        let dependencyManager = LiveDependencyManager()
        let storage = makeStorage()
        dependencyManager.register(storage, for: LocalStorage.self)
        return dependencyManager
    }

    @MainActor
    static func makeSwinjectDependencyContainer() -> Container {
        let container = Container()
        let storage = makeStorage()
        container.register(LocalStorage.self) { _ in storage }
        return container
    }

    static func makeStorage() -> LocalStorage {
        let userDefaults = UserDefaultsFactory.make()
        let storage = LiveLocalStorage(userDefaults: userDefaults)
        return storage
    }
}

//
//  MainAppView.swift
//  iOS Dependency Injection Showcase
//

import DIShowcasePackage
import SwiftUI
import Swinject

/// The main app view allowing to switch between the tabs showcasing different types of Dependency Injections.
struct MainAppView: View {
    let dependencyProvider: DependencyProvider
    let dependencyContainer: Container
    let localStorage: LocalStorage

    var body: some View {
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

// MARK: - View factories:

private extension MainAppView {
    @MainActor
    var manualDIToDoListView: some View {
        ManualDIToDoListFactory.make(storage: localStorage)
    }

    @MainActor
    var dependencyProviderToDoListView: some View {
        DependencyProviderToDoListFactory.make(
            dependencyProvider: dependencyProvider
        )
    }

    @MainActor
    var thirdPartyDIDoListView: some View {
        ThirdPartyDIToDoListFactory.make(
            dependencyContainer: dependencyContainer
        )
    }
}

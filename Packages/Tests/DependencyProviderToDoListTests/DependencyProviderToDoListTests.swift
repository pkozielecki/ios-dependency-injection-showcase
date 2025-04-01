//
//  DependencyProviderToDoListTests.swift
//  iOS Dependency Injection Showcase
//

import Common
@testable import CommonUI
@testable import DependencyProviderToDoList
import Testing
import TestUtils

@MainActor
struct DependencyProviderToDoListTests {
    private let sut: DependencyProviderToDoListFactory.Type
    private init() {
        sut = DependencyProviderToDoListFactory.self
    }

    @Test
    func whenViewIsCreated_shoulProvideItWithDependencies() async {
        //  given:
        let fakeDependencyProvider = FakeDependencyProvider()
        fakeDependencyProvider.simulatedDependencies = [
            String(describing: LocalStorage.self): setupLocalStorage(),
        ]

        //  when:
        let view = sut.make(dependencyProvider: fakeDependencyProvider)
        view.viewModel.load()

        //  then:
        executeSnapshotTests(
            forView: view,
            named: "DependencyProviderToDoListFactory - Todo list view"
        )
    }
}

private extension DependencyProviderToDoListTests {
    func setupLocalStorage() -> LocalStorage {
        let fakeStorage = FakeLocalStorage()
        fakeStorage.simulatedLoadedValue = [
            TodoItem(title: "First item"),
            TodoItem(title: "Second item"),
        ]
        return fakeStorage
    }
}

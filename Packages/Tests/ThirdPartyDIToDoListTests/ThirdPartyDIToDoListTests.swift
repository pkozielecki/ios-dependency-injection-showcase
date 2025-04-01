//
//  ThirdPartyDIToDoListTests.swift
//  iOS Dependency Injection Showcase
//

import Common
@testable import CommonUI
import Swinject
import Testing
import TestUtils
@testable import ThirdPartyDIToDoList

@MainActor
struct ThirdPartyDIToDoListTests {
    private let sut: ThirdPartyDIToDoListFactory.Type
    private init() {
        sut = ThirdPartyDIToDoListFactory.self
    }

    @Test
    func whenViewIsCreated_shoulProvideItWithDependencies() async {
        //  given:
        let fixtureContainer = Container()
        fixtureContainer.register(LocalStorage.self) { _ in
            setupLocalStorage()
        }

        //  when:
        let view = sut.make(dependencyContainer: fixtureContainer)
        view.viewModel.load()

        //  then:
        executeSnapshotTests(
            forView: view,
            named: "ThirdPartyDIToDoListFactory - Todo list view"
        )
    }
}

private extension ThirdPartyDIToDoListTests {
    func setupLocalStorage() -> LocalStorage {
        let fakeStorage = FakeLocalStorage()
        fakeStorage.simulatedLoadedValue = [
            TodoItem(title: "First item"),
            TodoItem(title: "Second item"),
        ]
        return fakeStorage
    }
}

//
//  ManualDIToDoListTests.swift
//  iOS Dependency Injection Showcase
//

import Common
@testable import CommonUI
@testable import ManualDIToDoList
import Testing
import TestUtils

@MainActor
struct ManualDIToDoListFactoryTests {
    private let sut: ManualDIToDoListFactory.Type
    private init() {
        sut = ManualDIToDoListFactory.self
    }

    @Test
    func whenViewIsCreated_shoulProvideItWithDependencies() async {
        //  given:
        let fakeStorage = FakeLocalStorage()
        fakeStorage.simulatedLoadedValue = [
            TodoItem(title: "First item"),
            TodoItem(title: "Second item"),
        ]

        //  when:
        let view = sut.make(storage: fakeStorage)
        view.viewModel.load()

        //  then:
        executeSnapshotTests(
            forView: view,
            named: "ManualDIToDoListFactory - Todo list view"
        )
    }
}

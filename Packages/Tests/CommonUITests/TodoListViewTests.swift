//
//  TodoListViewTests.swift
//  iOS Dependency Injection Showcase
//

import Common
@testable import CommonUI
import Testing
import TestUtils

@MainActor
struct TodoListViewTests {
    private let fakeViewModel: FakeTodoListViewModel
    private let sut: TodoListView
    private init() {
        fakeViewModel = FakeTodoListViewModel()
        sut = TodoListView(viewModel: fakeViewModel)
    }

    @Test
    func whenTodoListIsEmpty_shouldRenderProperView() async {
        //  given:
        fakeViewModel.simulatedToDoItems = []

        //  then:
        executeSnapshotTests(
            forView: sut,
            named: "TodoListView - empty"
        )
    }

    @Test
    func whenTodoListHasItems_shouldRenderProperView() async {
        //  given:
        fakeViewModel.simulatedToDoItems = [
            TodoItem(title: "First item"),
            TodoItem(title: "Second item"),
            TodoItem(title: "Third item"),
            TodoItem(title: "Last item"),
        ]

        //  then:
        executeSnapshotTests(
            forView: sut,
            named: "TodoListView - 4 items"
        )
    }

    #warning("DI-006 - Test error alert once extracted to a dedicated view")
}

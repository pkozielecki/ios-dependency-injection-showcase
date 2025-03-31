//
//  LiveTodoListViewModelTests.swift
//  iOS Dependency Injection Showcase
//

@testable import Common
import CustomDump
import Testing
import TestUtils

struct LiveTodoListViewModelTests {
    let fixtureTitle = "Test Todo List"
    var sut: LiveTodoListViewModel
    var fakeLocalStorage: FakeLocalStorage

    private init() {
        fakeLocalStorage = FakeLocalStorage()
        sut = LiveTodoListViewModel(
            storageService: fakeLocalStorage,
            title: fixtureTitle
        )
    }

    @Test
    func whenInitialized_shouldProvideProperState() {
        #expect(sut.title == fixtureTitle, "Should have proprer title")
        #expect(sut.todoItems.isEmpty, "")
        #expect(sut.errorMessage == nil, "")
    }

    @Test
    func whenLoadedItemsFromStorage_shouldPropagateProperState() {
        //  given:
        let todoItems = [TodoItem(title: "Test Item")]
        fakeLocalStorage.simulatedLoadedValue = todoItems

        //  when:
        sut.load()

        //  then:
        #expect(
            sut.todoItems == todoItems,
            "Should return proper list of items"
        )
        #expect(
            sut.errorMessage == nil,
            "Shoud compose no error message"
        )
    }

    @Test
    func whenLoadingItemsFailed_shouldPropagateProperState() {
        //  given:
        let fixtureError = FakeError.default
        fakeLocalStorage.simulatedLoadError = fixtureError

        //  when:
        sut.load()

        //  then:
        let expectedErrorMessage = "Failed to load todos: \(fixtureError.localizedDescription)"
        #expect(
            sut.todoItems.isEmpty == true,
            "Should return empty TODO items list"
        )
        #expect(
            sut.errorMessage == expectedErrorMessage,
            "Should compose proper error message"
        )
    }

    @Test
    func whenAddingItem_shouldPersistChanges() {
        //  given:
        let fixtureItem = TodoItem(title: "Test Item")

        //  when:
        sut.add(todo: fixtureItem)

        //  then:
        #expect(
            sut.todoItems == [fixtureItem],
            "Should add item to the list"
        )
        #expect(
            fakeLocalStorage.lastSavedValue as? [TodoItem] == [fixtureItem],
            "Shoud save items"
        )
        #expect(
            fakeLocalStorage.lastSavedKey == StorageKeys.todoList.rawValue,
            "Shoud save items under the right key"
        )
    }

    @Test
    func whenAddingItem_andSavingFailed_shouldSaveChanges() {
        //  given:
        let fixtureError = FakeError.default
        fakeLocalStorage.simulatedSaveError = fixtureError

        //  when:
        sut.add(todo: TodoItem(title: "Test Item"))

        //  then:
        let expectedErrorMessage = "Failed to save todos: \(fixtureError.localizedDescription)"
        #expect(
            sut.errorMessage == expectedErrorMessage,
            "Should compose proper error message"
        )
    }

    @Test
    func whenAddingItemWithEmptyTitle_shouldNotSaveChanges() {
        //  when:
        sut.add(todo: TodoItem(title: ""))

        //  then:
        #expect(
            sut.todoItems.isEmpty == true,
            "Should not add an empty item"
        )
    }

    @Test
    func whenUpdatedExistingItem_shouldSaveChanges() {
        //  given:
        let fixtureItem = TodoItem(title: "Test Item")
        sut.add(todo: fixtureItem)

        //  when:
        var updatedFixtureItem = fixtureItem
        updatedFixtureItem.title = "Updated"
        sut.update(todo: updatedFixtureItem)

        //  then:
        #expect(
            sut.todoItems == [updatedFixtureItem],
            "Should update item in the list"
        )
        #expect(
            fakeLocalStorage.lastSavedValue as? [TodoItem] == [updatedFixtureItem],
            "Shoud save items"
        )
        #expect(
            fakeLocalStorage.lastSavedKey == StorageKeys.todoList.rawValue,
            "Shoud save items under the right key"
        )
    }

    @Test
    func whenCompleteExistingItem_shouldSaveChanges() {
        //  given:
        let fixtureItem = TodoItem(title: "Test Item")
        sut.add(todo: fixtureItem)

        //  when:
        sut.toggleCompletion(for: fixtureItem)

        //  then:
        var expectedItem = fixtureItem
        expectedItem.isCompleted = true
        expectNoDifference(
            sut.todoItems,
            [expectedItem],
            "Should set item as completed in the list"
        )
        expectNoDifference(
            fakeLocalStorage.lastSavedValue as? [TodoItem],
            [expectedItem],
            "Shoud save items"
        )
        #expect(
            fakeLocalStorage.lastSavedKey == StorageKeys.todoList.rawValue,
            "Shoud save items under the right key"
        )
    }

    @Test
    func whenDeleteRequested_shouldDeleteCorrectItem() {
        //  given:
        let fixtureItem = TodoItem(title: "Test Item")
        let fixtureItemToDelete = TodoItem(title: "Test Item to delete")
        sut.add(todo: fixtureItem)
        sut.add(todo: fixtureItemToDelete)

        //  when:
        sut.delete(todo: fixtureItemToDelete)

        //  then:
        expectNoDifference(
            sut.todoItems,
            [fixtureItem],
            "Should save proper items"
        )
        expectNoDifference(
            fakeLocalStorage.lastSavedValue as? [TodoItem],
            [fixtureItem],
            "Shoud save items"
        )
        #expect(
            fakeLocalStorage.lastSavedKey == StorageKeys.todoList.rawValue,
            "Shoud save items under the right key"
        )
    }
}

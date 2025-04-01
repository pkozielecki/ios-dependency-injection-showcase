//
//  LiveLocalStorageTests.swift
//  iOS Dependency Injection Showcase
//

import Foundation
@testable import Storage
import Testing
import TestUtils

struct LiveLocalStorageTests {
    private let fixtureKey = "testItem"
    private let fakeUserDefaults: FakeUserDefaults!
    private let sut: LiveLocalStorage

    private init() {
        fakeUserDefaults = FakeUserDefaults()
        sut = LiveLocalStorage(userDefaults: fakeUserDefaults)
    }

    @Test
    func whenSavingData_shouldEncodeItAndStoreInUserDefaults() throws {
        // given:
        let fixtureItem = TestItem(id: 123, name: "Test Item")

        // when:
        try sut.save(fixtureItem, forKey: fixtureKey)

        // then:
        let lastSavedValue = fakeUserDefaults.lastSetValue as? Data ?? Data()
        let expectedItem = try JSONDecoder().decode(TestItem.self, from: lastSavedValue)
        #expect(
            expectedItem == fixtureItem,
            "Should encode value and store it"
        )
        #expect(
            fakeUserDefaults.lastSetKey == fixtureKey,
            "Should use proper key"
        )
    }

    @Test
    func whenLoadingData_shouldLoadItFromUserDefaultsAndDecode() throws {
        // given:
        let fixtureNumber = 111
        let fixtureEncodedNumber = try? JSONEncoder().encode(fixtureNumber)
        fakeUserDefaults.simulatedData = [fixtureKey: fixtureEncodedNumber!]

        // when:
        let retrievedNumber: Int? = try sut.load(forKey: fixtureKey)

        // then:
        #expect(
            retrievedNumber == fixtureNumber,
            "Should retrieve proper value"
        )
    }

    @Test
    func whenRemovingData_shouldEraseItFromUserDefaults() throws {
        // given:
        let fixtureBool = false
        let fixtureEncodedBool = try? JSONEncoder().encode(fixtureBool)
        fakeUserDefaults.simulatedData = [fixtureKey: fixtureEncodedBool!]

        // when:
        sut.remove(forKey: fixtureKey)

        // then:
        #expect(
            fakeUserDefaults.lastRemovedKey == fixtureKey,
            "Should erase value from a provided key"
        )
    }
}

private struct TestItem: Codable, Equatable {
    let id: Int
    let name: String
}

private extension TestItem {
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}

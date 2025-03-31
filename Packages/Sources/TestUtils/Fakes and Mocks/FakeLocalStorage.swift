//
//  FakeLocalStorage.swift
//  iOS Dependency Injection Showcase
//

import Common
import Foundation

public final class FakeLocalStorage: @unchecked Sendable, LocalStorage {
    public var simulatedSaveError: Error?
    public var simulatedLoadError: Error?
    public var simulatedLoadedValue: Any?

    public private(set) var lastSavedKey: String?
    public private(set) var lastSavedValue: Any?
    public private(set) var lastRemovedKey: String?
    public private(set) var lastLoadKey: String?

    public init() {}

    public func load<T>(forKey key: String) throws -> T? {
        if let simulatedLoadError {
            throw simulatedLoadError
        }
        lastLoadKey = key
        return simulatedLoadedValue as? T
    }

    public func save(_ value: some Any, forKey key: String) throws {
        if let simulatedSaveError {
            throw simulatedSaveError
        }
        lastSavedKey = key
        lastSavedValue = value
    }

    public func remove(forKey key: String) {
        lastRemovedKey = key
    }
}

//
//  FakeUserDefaults.swift
//  iOS Dependency Injection Showcase
//

import Common
import Foundation

public final class FakeUserDefaults: @unchecked Sendable, UserDefaultsWrapper {
    public var simulatedData: [String: Any] = [:]
    public private(set) var lastSetValue: Any?
    public private(set) var lastSetKey: String?
    public private(set) var lastRemovedKey: String?

    public init() {}

    public func set(_ value: Any?, forKey defaultName: String) {
        lastSetValue = value
        lastSetKey = defaultName
        simulatedData[defaultName] = value
    }

    public func data(forKey defaultName: String) -> Data? {
        simulatedData[defaultName] as? Data
    }

    public func removeObject(forKey defaultName: String) {
        lastRemovedKey = defaultName
        simulatedData.removeValue(forKey: defaultName)
    }
}

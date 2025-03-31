//
//  SnapshotTests.swift
//  iOS Dependency Injection Showcase
//

import Foundation
import SnapshotTesting
import SwiftUI
import UIKit

@MainActor
public func executeSnapshotTests(
    forView view: any View,
    named name: String,
    precision: Float = 0.995,
    isRecording: Bool = false,
    file filePath: StaticString = #filePath,
    functionName: String = #function,
    line: UInt = #line
) {
    let viewController = UIHostingController(rootView: AnyView(view))
    executeSnapshotTests(
        forViewController: viewController,
        named: name,
        precision: precision,
        isRecording: isRecording,
        filePath: filePath,
        functionName: functionName,
        line: line
    )
}

@MainActor
public func executeSnapshotTests(
    forViewController viewController: UIViewController,
    named name: String,
    precision: Float = 0.995,
    isRecording: Bool = false,
    filePath: StaticString = #filePath,
    functionName: String = #function,
    line: UInt = #line
) {
    viewController.loadViewIfNeeded()
    viewController.forceLightMode()
    assertSnapshot(
        of: viewController,
        as: .image(on: .iPhone13Pro, precision: precision, perceptualPrecision: 0.98),
        named: name,
        record: isRecording,
        file: filePath,
        testName: "iPhone13Pro",
        line: line
    )
}

extension UIViewController {
    /// Forcing light mode to ensure test won't fail on the simulator with dark mode turned on.
    func forceLightMode() {
        overrideUserInterfaceStyle = .light
    }
}

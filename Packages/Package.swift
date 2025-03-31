// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// The `Package` instance representing the DIShowcaseModules modules.
let package = Package(
    name: "DIShowcaseModules",
    platforms: [
        .iOS("17.6"),
    ],
    products: [
        /// App package: Gathers all the dependencies to be injected in to the main app.
        .singleTargetLibrary("DIShowcasePackage"),

        /// Test helpers: A helper library for Unit Tests.
        .singleTargetLibrary("TestUtils"),
    ],
    dependencies: [
        /// Tools dependency:
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.5.2"),
        .package(url: "https://github.com/Swinject/Swinject", exact: "2.9.1"),

        /// Tests dependencies:
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", exact: "1.18.1"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", exact: "1.3.3"),
        .package(url: "https://github.com/nalexn/ViewInspector", exact: "0.10.1"),
    ],
    targets: Package.targets
)

extension Package {
    /// The array of targets in this package.
    @MainActor static var targets: [Target] = [
        // App packages:
        .target(
            name: "DIShowcasePackage",
            dependencies: [
                // Common dependencies
                "CommonUI",
                "Common",

                // Utility dependencies
                "Storage",

                // Features:
                "ManualDIToDoList",
                "DependencyProviderToDoList",
                "ThirdPartyDIToDoList",
            ]
        ),

        // Feature modules:
        .target(
            name: "ThirdPartyDIToDoList",
            dependencies: Dependencies.common + [
                .product(name: "Swinject", package: "Swinject"),
            ]
        ),
        .target(
            name: "ManualDIToDoList",
            dependencies: Dependencies.common + []
        ),
        .target(
            name: "DependencyProviderToDoList",
            dependencies: Dependencies.common + []
        ),

        // Utility modules:
        .target(
            name: "Storage",
            dependencies: [
                "Common",
            ],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),

        // Common modules:
        .target(
            name: "CommonUI",
            dependencies: [
                "Common",
                .product(name: "Inject", package: "Inject"),
            ],
            swiftSettings: [
                .define("ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS"),
                SwiftSetting.swiftLanguageVersion,
            ]
        ),
        .target(
            name: "Common",
            dependencies: [],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),

        // Test tools:
        .target(
            name: "TestUtils",
            dependencies: Dependencies.common + [
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "ViewInspector", package: "ViewInspector"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
            ],
            swiftSettings: [
                .define("ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS"),
                SwiftSetting.swiftLanguageVersion,
            ]
        ),

        // Common test modules:
        .testTarget(
            name: "CommonTests",
            dependencies: Dependencies.test + ["Common"],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),
        .testTarget(
            name: "CommonUITests",
            dependencies: Dependencies.test + ["CommonUI"],
            swiftSettings: [
                .define("ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS"),
                SwiftSetting.swiftLanguageVersion,
            ]
        ),

        // Utility test modules:
        .testTarget(
            name: "StorageTests",
            dependencies: Dependencies.test + ["Storage"],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),

        // Feature test modules:
        .testTarget(
            name: "ManualDIToDoListTests",
            dependencies: Dependencies.test + ["ManualDIToDoList"],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),
        .testTarget(
            name: "DependencyProviderToDoListTests",
            dependencies: Dependencies.test + ["DependencyProviderToDoList"],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),
        .testTarget(
            name: "ThirdPartyDIToDoListTests",
            dependencies: Dependencies.test + ["ThirdPartyDIToDoList"],
            swiftSettings: [SwiftSetting.swiftLanguageVersion]
        ),
    ]
}

/// Defines common and test dependency sets.
enum Dependencies {
    /// Common dependencies shared across targets.
    static var common: [Target.Dependency] {
        [
            "CommonUI",
            "Common",
        ]
    }

    /// Dependencies specific to test targets.
    static var test: [Target.Dependency] {
        [
            "TestUtils",
        ]
    }
}

/// Extends `Product` to define a helper method for single target libraries.
extension Product {
    /// Creates a single target library product.
    /// - Parameter name: The name of the library.
    /// - Returns: A `Product` instance representing the library.
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}

/// Extends `SwiftSetting` to define custom Swift language settings.
extension SwiftSetting {
    /// Specifies the Swift language version setting.
    static var swiftLanguageVersion: PackageDescription.SwiftSetting {
        .swiftLanguageMode(.v6)
    }
}

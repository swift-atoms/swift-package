// swift-tools-version: 6.3.3

import PackageDescription

// Package Primitives — L1 typed identifiers for the Swift package
// management domain.
//
// Provides phantom-typed string identifiers for Swift packages,
// products, and targets so the type system can distinguish them at
// compile time. Backed by Tagged<Tag, Swift.String>; consumers gain
// type discrimination without runtime cost.
//
// Per the typed-identifier-naming framework (swift-institute/Research/
// 2026-05-12-typed-identifier-naming-framework.md), the namespace is
// the most-generic English noun for the domain entity — Package,
// Product, Target — rather than a brand-flavored SwiftPM.* namespace.
// This enables cross-ecosystem reuse: tooling that handles Swift
// package metadata (registry tools, dependency analyzers, manifest
// generators) consumes the typed identifiers without dragging in a
// consumer-flavored namespace.
//
// Design Research at swift-institute/Research/
// 2026-05-12-swift-package-and-version-primitives-design.md v1.0.0.

let package = Package(
    name: "swift-package-primitives",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        .library(
            name: "Package Primitives",
            targets: ["Package Primitives"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Package Primitives",
            dependencies: [
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Tagged Primitives Standard Library Integration", package: "swift-tagged-primitives"),
            ]
        ),
        .testTarget(
            name: "Package Primitives Tests",
            dependencies: [
                "Package Primitives",
            ],
            path: "Tests/Package Primitives Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

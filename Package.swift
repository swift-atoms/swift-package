// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-package",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Package",
            targets: ["Package"]
        ),
        .library(
            name: "Package Standard Library Integration",
            targets: ["Package Standard Library Integration"]
        ),
        .library(
            name: "Package Apple Foundation Integration",
            targets: ["Package Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Package",
            dependencies: []
        ),
        .target(
            name: "Package Standard Library Integration",
            dependencies: ["Package"]
        ),
        .target(
            name: "Package Apple Foundation Integration",
            dependencies: [
                "Package",
                "Package Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Package Tests",
            dependencies: ["Package"],
            path: "Tests/Package Tests"
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
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

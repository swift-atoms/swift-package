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
        .library(name: "Package", targets: ["Package"]),

        .library(name: "Package Foundation Integration", targets: ["Package Foundation Integration"]),
        .library(name: "Package Test Support", targets: ["Package Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "Package",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Package"
        ),
        
        .target(
            name: "Package Foundation Integration",
            dependencies: [
                .target(name: "Package"),
            ],
            path: "Sources/Package Foundation Integration"
        ),
        .target(
            name: "Package Test Support",
            dependencies: [
                .target(name: "Package"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Package Tests",
            dependencies: [
                .target(name: "Package"),
                .target(name: "Package Test Support"),
                .target(name: "Package Foundation Integration"),
            ],
            path: "Tests/Package Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}

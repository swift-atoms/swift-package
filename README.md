# swift-package

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Typed identifiers for the Swift package management domain. Provides
phantom-typed string wrappers for Swift package names, product names,
and target names so the type system distinguishes them at compile time.

The package follows the institute's typed-identifier-naming framework
(see `swift-institute/Research/2026-05-12-typed-identifier-naming-framework.md`):
the namespace is the generic English noun for the domain entity
(`Package`, `Product`, `Target`) rather than a brand-flavored
`SwiftPM.*` namespace. Cross-ecosystem tooling — registry analyzers,
dependency-graph analyzers, manifest generators — adopts the types
without importing a consumer-flavored surface.

## Quick Start

```swift
import Package

let packageName: Package.Name = "swift-molecules"
let productName: Product.Name = "Package"
let targetName: Target.Name = "Package"

// Type discrimination prevents mix-ups at the type system:
// packageName == productName  // ❌ compile error: different types
```

Each type is `Tagged<Tag, Swift.String>` — a zero-cost phantom wrapper.
Conformances inherited from `Tagged` (Sendable, Hashable, Equatable,
Comparable, Codable, CustomStringConvertible, ExpressibleByStringLiteral
via the standard-library-integration target).

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-package.git", branch: "main"),
]
```

> Pre-1.0: no version tags yet. APIs may change; pin a commit for reproducible builds.

```swift
.target(
    name: "YourPackage",
    dependencies: [
        .product(name: "Package", package: "swift-package"),
    ]
)
```

`Package` re-exports `Tagged` and
`Tagged_Standard_Library_Integration`; consumers do not
import them separately to construct values via string literal.

## What's in the namespace

| Type | Backing | Purpose |
|------|---------|---------|
| `Package.Name` | `Tagged<Package, Swift.String>` | Manifest-level `Package(name:)` identifier. |
| `Product.Name` | `Tagged<Product, Swift.String>` | Manifest-level `Product(name:)` identifier. |
| `Target.Name` | `Tagged<Target, Swift.String>` | Manifest-level `Target(name:)` identifier. |

## Validation

None at construction time. Upstream SwiftPM enforces only emptiness
for manifest-level names (see
`swiftlang/swift-package-manager` `Sources/PackageModel/Manifest/Manifest.swift:31`,
`Sources/PackageLoading/PackageBuilder.swift:837-844, 1576-1578`);
institute consumers inherit the same permissive contract. Product and
target names commonly contain spaces per institute convention
(`"Tagged Standard Library Integration"`); the permissive
contract preserves that usage.

The stricter SE-0292 registry-identifier rules apply to a separate
type (`Package.Identity` — deferred to a future version).

## Foundation-clean

This package imports no `Foundation` and depends only on
`swift-tagged` (Tier 0 primitives). Cross-ecosystem
consumers — Rust/Cargo bridges, NPM bridges, registry tooling —
adopt the types without inheriting a Foundation dependency.

## Design

- Research: `swift-institute/Research/2026-05-12-swift-package-and-version-primitives-design.md` v1.0.0 RECOMMENDATION
- Framework: `swift-institute/Research/2026-05-12-typed-identifier-naming-framework.md` v1.0.0 RECOMMENDATION

## License

Apache 2.0 — see `LICENSE.md`.

#if os(macOS)
import Foundation
import Testing

@Suite(.serialized) struct `The compiler preserves package name domains` {
    enum Domain: String, CaseIterable, Sendable {
        case package = "PACKAGE"
        case product = "PRODUCT"
        case target = "TARGET"
    }

    @Test(arguments: Domain.allCases, Domain.allCases)
    func `names can be assigned only within their declared domain`(
        source: Domain, destination: Domain
    ) throws {
        var products = Bundle.module.bundleURL
        while !FileManager.default.fileExists(
            atPath: products.appendingPathComponent("Package.swiftmodule").path
        ) {
            let parent = products.deletingLastPathComponent()
            products = try #require(parent != products ? parent : nil)
        }
        let fixture = try #require(Bundle.module.resourceURL)
            .appendingPathComponent("Name domains.swift")
        let process = Process()
        let errors = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/xcrun")
        process.arguments = [
            "swiftc", "-typecheck", "-swift-version", "6",
            "-enable-experimental-feature", "Lifetimes",
            "-module-name", "PackageDomainClient", "-I", products.path,
            "-D", "SOURCE_\(source.rawValue)",
            "-D", "DESTINATION_\(destination.rawValue)", fixture.path,
        ]
        process.standardError = errors
        try process.run()
        let diagnostic = String(
            decoding: errors.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self
        )
        process.waitUntilExit()
        #expect(process.terminationReason == .exit, "\(diagnostic)")
        #expect((process.terminationStatus == 0) == (source == destination), "\(diagnostic)")
        if source != destination {
            #expect(diagnostic.contains("cannot assign value of type"), "\(diagnostic)")
            #expect(diagnostic.contains("arguments to generic parameter 'Tag'"), "\(diagnostic)")
        }
        #expect(!diagnostic.contains("no such module"), "\(diagnostic)")
    }
}
#endif

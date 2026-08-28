import Package
import Testing

@Suite
struct `Package.Name Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Package.Name Tests`.Unit {
    @Test
    func `Constructs from string literal`() {
        let name: Package.Name = "swift-package"
        #expect(name.underlying == "swift-package")
    }

    @Test
    func `Equal values compare equal`() {
        let a: Package.Name = "swift-package"
        let b: Package.Name = "swift-package"
        #expect(a == b)
    }

    @Test
    func `Distinct values compare unequal`() {
        let a: Package.Name = "swift-package"
        let b: Package.Name = "swift-standards"
        #expect(a != b)
    }

    @Test
    func `Hashable conformance distinguishes values`() {
        var set: Swift.Set<Package.Name> = []
        set.insert("swift-package")
        set.insert("swift-standards")
        set.insert("swift-package")
        #expect(set.count == 2)
    }

    @Test
    func `Comparable orders lexicographically`() {
        let a: Package.Name = "swift-a"
        let b: Package.Name = "swift-b"
        #expect(a < b)
    }
}

extension `Package.Name Tests`.`Edge Case` {
    @Test
    func `Empty string is accepted (permissive contract)`() {
        let name: Package.Name = ""
        #expect(name.underlying.isEmpty)
    }

    @Test
    func `Spaces are accepted (permissive contract)`() {
        let name: Package.Name = "Some Name With Spaces"
        #expect(name.underlying == "Some Name With Spaces")
    }
}

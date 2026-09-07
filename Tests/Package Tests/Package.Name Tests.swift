import Package
import Testing

@Suite
struct `Package names preserve their declared values` {
    @Suite struct `Names retain their values` {}
    @Suite struct `Names accept permissive input` {}
    @Suite struct `Names preserve their domain` {}
}

extension `Package names preserve their declared values`.`Names retain their values` {
    @Test
    func `names can be constructed from string literals`() {
        let name: Package.Name = "swift-package"
        #expect(name.underlying == "swift-package")
    }

    @Test
    func `equal names compare equal`() {
        let a: Package.Name = "swift-package"
        let b: Package.Name = "swift-package"
        #expect(a == b)
    }

    @Test
    func `distinct names compare unequal`() {
        let a: Package.Name = "swift-package"
        let b: Package.Name = "swift-standards"
        #expect(a != b)
    }

    @Test
    func `hashed collections distinguish name values`() {
        var set: Swift.Set<Package.Name> = []
        set.insert("swift-package")
        set.insert("swift-standards")
        set.insert("swift-package")
        #expect(set.count == 2)
    }

    @Test
    func `names sort lexicographically`() {
        let a: Package.Name = "swift-a"
        let b: Package.Name = "swift-b"
        #expect(a < b)
    }
}

extension `Package names preserve their declared values`.`Names accept permissive input` {
    @Test
    func `empty names remain valid`() {
        let name: Package.Name = ""
        #expect(name.underlying.isEmpty)
    }

    @Test
    func `names preserve embedded spaces`() {
        let name: Package.Name = "Some Name With Spaces"
        #expect(name.underlying == "Some Name With Spaces")
    }
}

import Package
import Testing

@Suite
struct `Target.Name Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Target.Name Tests`.Unit {
    @Test
    func `Constructs from string literal`() {
        let name: Target.Name = "Package"
        #expect(name.underlying == "Package")
    }

    @Test
    func `Equal values compare equal`() {
        let a: Target.Name = "Package"
        let b: Target.Name = "Package"
        #expect(a == b)
    }

    @Test
    func `Hashable conformance distinguishes values`() {
        var set: Swift.Set<Target.Name> = []
        set.insert("Package")
        set.insert("Package Tests")
        #expect(set.count == 2)
    }
}

extension `Target.Name Tests`.Integration {
    @Test
    func `Type discrimination — Package.Name and Target.Name are distinct types`() {
        let pkg: Package.Name = "swift-molecules"
        let tgt: Target.Name = "Package"
        #expect(pkg.underlying == "swift-molecules")
        #expect(tgt.underlying == "Package")
    }
}

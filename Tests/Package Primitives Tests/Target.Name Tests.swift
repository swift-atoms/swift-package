import Package_Primitives
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
        let name: Target.Name = "Package Primitives"
        #expect(name.underlying == "Package Primitives")
    }

    @Test
    func `Equal values compare equal`() {
        let a: Target.Name = "Package Primitives"
        let b: Target.Name = "Package Primitives"
        #expect(a == b)
    }

    @Test
    func `Hashable conformance distinguishes values`() {
        var set: Swift.Set<Target.Name> = []
        set.insert("Package Primitives")
        set.insert("Package Primitives Tests")
        #expect(set.count == 2)
    }
}

extension `Target.Name Tests`.Integration {
    @Test
    func `Type discrimination — Package.Name and Target.Name are distinct types`() {
        let pkg: Package.Name = "swift-primitives"
        let tgt: Target.Name = "Package Primitives"
        #expect(pkg.underlying == "swift-primitives")
        #expect(tgt.underlying == "Package Primitives")
    }
}

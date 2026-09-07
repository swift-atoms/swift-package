import Package
import Testing

@Suite
struct `Target names preserve their declared values` {
    @Suite struct `Names retain their values` {}
    @Suite struct `Names accept permissive input` {}
    @Suite struct `Names preserve their domain` {}
}

extension `Target names preserve their declared values`.`Names retain their values` {
    @Test
    func `names can be constructed from string literals`() {
        let name: Target.Name = "Package"
        #expect(name.underlying == "Package")
    }

    @Test
    func `equal names compare equal`() {
        let a: Target.Name = "Package"
        let b: Target.Name = "Package"
        #expect(a == b)
    }

    @Test
    func `hashed collections distinguish name values`() {
        var set: Swift.Set<Target.Name> = []
        set.insert("Package")
        set.insert("Package Tests")
        #expect(set.count == 2)
    }
}

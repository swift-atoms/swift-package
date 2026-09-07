import Package
import Testing

@Suite
struct `Product names preserve their declared values` {
    @Suite struct `Names retain their values` {}
    @Suite struct `Names accept permissive input` {}
    @Suite struct `Names preserve their domain` {}
}

extension `Product names preserve their declared values`.`Names retain their values` {
    @Test
    func `names can be constructed from string literals`() {
        let name: Product.Name = "Package"
        #expect(name.underlying == "Package")
    }

    @Test
    func `equal names compare equal`() {
        let a: Product.Name = "Package"
        let b: Product.Name = "Package"
        #expect(a == b)
    }

    @Test
    func `hashed collections distinguish name values`() {
        var set: Swift.Set<Product.Name> = []
        set.insert("Package")
        set.insert("Version")
        set.insert("Package")
        #expect(set.count == 2)
    }
}

extension `Product names preserve their declared values`.`Names accept permissive input` {
    @Test
    func `names preserve embedded spaces`() {
        let name: Product.Name = "Package Tagged"
        #expect(name.underlying == "Package Tagged")
    }
}

import Package
import Testing

@Suite
struct `Product.Name Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Product.Name Tests`.Unit {
    @Test
    func `Constructs from string literal`() {
        let name: Product.Name = "Package"
        #expect(name.underlying == "Package")
    }

    @Test
    func `Equal values compare equal`() {
        let a: Product.Name = "Package"
        let b: Product.Name = "Package"
        #expect(a == b)
    }

    @Test
    func `Hashable conformance distinguishes values`() {
        var set: Swift.Set<Product.Name> = []
        set.insert("Package")
        set.insert("Version")
        set.insert("Package")
        #expect(set.count == 2)
    }
}

extension `Product.Name Tests`.`Edge Case` {
    @Test
    func `Spaces are accepted (institute convention)`() {
        let name: Product.Name = "Tagged"
        #expect(name.underlying == "Tagged")
    }
}

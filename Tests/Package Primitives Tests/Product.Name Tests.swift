import Package_Primitives
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
        let name: Product.Name = "Package Primitives"
        #expect(name.underlying == "Package Primitives")
    }

    @Test
    func `Equal values compare equal`() {
        let a: Product.Name = "Package Primitives"
        let b: Product.Name = "Package Primitives"
        #expect(a == b)
    }

    @Test
    func `Hashable conformance distinguishes values`() {
        var set: Swift.Set<Product.Name> = []
        set.insert("Package Primitives")
        set.insert("Version Primitives")
        set.insert("Package Primitives")
        #expect(set.count == 2)
    }
}

extension `Product.Name Tests`.`Edge Case` {
    @Test
    func `Spaces are accepted (institute convention)`() {
        let name: Product.Name = "Tagged Primitives Standard Library Integration"
        #expect(name.underlying == "Tagged Primitives Standard Library Integration")
    }
}

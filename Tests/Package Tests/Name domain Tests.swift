import Foundation
import Package
import Testing

@Suite struct `Package names preserve their values and capabilities` {
    @Test(arguments: ["", "A name with spaces", "é", "quote\"and\\slash", "line\nbreak"])
    func `all name domains retain permissive strings through persistence`(text: String) throws {
        try roundTrip(Package.Name(_unchecked: text), text: text)
        try roundTrip(Product.Name(_unchecked: text), text: text)
        try roundTrip(Target.Name(_unchecked: text), text: text)
    }

    @Test func `all domains preserve string ordering and keyed collection behavior`() {
        checkOrderingAndKeys(Package.Name.self)
        checkOrderingAndKeys(Product.Name.self)
        checkOrderingAndKeys(Target.Name.self)
    }

    @Test func `equal strings in different domains remain distinct erased values`() {
        let package: Package.Name = "Same name"
        let product: Product.Name = "Same name"
        let target: Target.Name = "Same name"
        #expect(Set([AnyHashable(package), AnyHashable(product), AnyHashable(target)]).count == 3)
        #expect((package as Any) is Package.Name)
        #expect(!((package as Any) is Product.Name))
        #expect(!((package as Any) is Target.Name))
    }

    @Test func `each name domain can cross an actor boundary without changing its value`() async {
        let receiver = Receiver()
        let values: (Package.Name, Product.Name, Target.Name) = ("Package name", "Product name", "Target name")
        let received = await receiver.receive(values)
        #expect(received.0 == values.0)
        #expect(received.1 == values.1)
        #expect(received.2 == values.2)
    }

    private func roundTrip<Domain>(
        _ name: Tagged<Domain, String>, text: String
    ) throws {
        let encoded = try JSONEncoder().encode(name)
        #expect(try JSONDecoder().decode(String.self, from: encoded) == text)
        #expect(try JSONDecoder().decode(Tagged<Domain, String>.self, from: encoded) == name)
        #expect(name.description == text)
        #expect(Tagged<Domain, String>(text) == name)
        #expect(Array(name) == Array(text))
    }

    private func checkOrderingAndKeys<Name>(_: Name.Type)
    where Name: Comparable & Hashable & Sendable & ExpressibleByStringLiteral {
        let first: Name = "A name"
        let last: Name = "Z name"
        #expect([last, first].sorted() == [first, last])
        var dictionary = [first: 1, last: 2]
        let same: Name = "A name"
        dictionary[same] = 3
        #expect(dictionary.count == 2)
        #expect(dictionary[first] == 3)
        #expect(dictionary[last] == 2)
    }

    private actor Receiver {
        func receive(_ values: (Package.Name, Product.Name, Target.Name))
            -> (Package.Name, Product.Name, Target.Name) { values }
    }
}

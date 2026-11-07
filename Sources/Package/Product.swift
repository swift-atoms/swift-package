public enum Product: Swift.Sendable {}

extension Product {

    public typealias Name = Tagged<Product, Swift.String>
}

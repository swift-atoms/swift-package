public enum Package: Swift.Sendable {}

extension Package {

    public typealias Name = Tagged<Package, Swift.String>
}

import Package
import Testing

@Suite
struct `Package Tests` {
    @Test
    func `Domain namespaces exist and are Sendable`() {
        let _: any Swift.Sendable.Type = Package.self
        let _: any Swift.Sendable.Type = Product.self
        let _: any Swift.Sendable.Type = Target.self
    }
}

import Package

#if SOURCE_PACKAGE
typealias Source = Package.Name
#elseif SOURCE_PRODUCT
typealias Source = Product.Name
#else
typealias Source = Target.Name
#endif

#if DESTINATION_PACKAGE
typealias Destination = Package.Name
#elseif DESTINATION_PRODUCT
typealias Destination = Product.Name
#else
typealias Destination = Target.Name
#endif

let source: Source = "Same name"
let destination: Destination = source

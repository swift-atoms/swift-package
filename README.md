# swift-package

Use this package when code passes Swift package, product or target names around and must not confuse one kind of name for another. Start from `Package.Name`, `Product.Name` and `Target.Name`: each is a `Tagged` wrapper around `Swift.String`, tagged with its domain (`Package`, `Product`, `Target`).

## Laws

- Names are never validated. Every string is a valid name in every domain, including the empty string, spaces, non-ASCII text, quotes, backslashes and line breaks, and the name stores it unchanged.
- Equality, hashing and ordering are those of the underlying `Swift.String`, so names sort lexicographically and two names with the same text in the same domain are the same key.
- A name encodes as its bare string and decodes from one; its description is that string.
- Domains never mix. A name from one domain cannot be assigned to another, and equal text in different domains stays distinct, even after erasure to `AnyHashable`.

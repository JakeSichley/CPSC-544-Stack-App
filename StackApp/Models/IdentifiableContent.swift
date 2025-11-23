import Foundation

public struct IdentifiableContent<Value>: Identifiable {
    
    // MARK: - Properties
    
    public let id: UUID = UUID()
    public let value: Value
    
    // MARK: - Lifecycle
    
    public init(_ value: Value) {
        self.value = value
    }
}

// MARK: - ExpressibleByLiteral

extension IdentifiableContent: ExpressibleByUnicodeScalarLiteral where Value == String {
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

extension IdentifiableContent: ExpressibleByExtendedGraphemeClusterLiteral where Value == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

extension IdentifiableContent: ExpressibleByStringLiteral where Value == String {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension IdentifiableContent: ExpressibleByIntegerLiteral where Value == Int {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

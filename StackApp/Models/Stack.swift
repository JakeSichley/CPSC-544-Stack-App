import SwiftUI

@Observable
public final class Stack<T> {
    
    // MARK: - Properties
    
    public private(set) var contents: [IdentifiableContent<T>]
    
    public var currentSize: Int {
        return contents.count
    }
    
    public var isEmpty: Bool {
        return contents.isEmpty
    }
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    // MARK: - Lifecycle
    
    public init() {
        contents = []
    }
    
    public init(_ elements: [T]) {
        contents = elements.map { .init($0) }
    }
    
    // MARK: - Tasks
    
    public func push(_ element: T) {
        contents.append(.init(element))
    }
    
    @discardableResult
    public func pop() -> T? {
        return contents.popLast()?.value
    }
    
    public func peek() -> T? {
        return contents.last?.value
    }
}

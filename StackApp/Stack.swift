//
//  Stack.swift
//  StackApp
//

import Foundation

public final class Stack<T> {
    
    // MARK: - Properties
    
    private var stack: [T]
    
    public var currentSize: Int {
        return stack.count
    }
    
    // MARK: - Lifecycle
    
    public init() {
        stack = []
    }
    
    public init(_ elements: [T]) {
        stack = elements
    }
    
    // MARK: - Tasks
    
    public func push(_ element: T) {
        stack.append(element)
    }
    
    public func pop() -> T? {
        return stack.popLast()
    }
    
    public func peek() -> T? {
        return stack.last
    }
}

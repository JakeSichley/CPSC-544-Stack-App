//
//  Stack.swift
//  StackApp
//

import Foundation

public struct Stack {
    public private(set) var contents: [Int]
    public let maxSize: Int

    public init(maxSize: Int = 3, contents: [Int] = []) {
        self.maxSize = maxSize
        self.contents = contents
    }

    public var isEmpty: Bool { contents.isEmpty }
    public var isFull: Bool { contents.count >= maxSize }

    public mutating func push(_ value: Int) -> PushOutcome {
        if isFull {
            return .full
        }
        contents.append(value)
        return .pushed(value)
    }

    public mutating func pop() -> PopOutcome {
        guard let last = contents.popLast() else {
            return .empty
        }
        return .popped(last)
    }
}

public enum PushOutcome: Equatable {
    case pushed(Int)
    case full
}

public enum PopOutcome: Equatable {
    case popped(Int)
    case empty
}

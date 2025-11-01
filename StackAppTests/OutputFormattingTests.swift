//
//  OutputFormattingTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class OutputFormattingTests: XCTestCase {

    func testLIFOOrderIsMaintained() {
        let stack = Stack<Int>()
        
        stack.push(1)
        stack.push(2)
        stack.push(3)
        
        // Last in, first out
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.pop(), 1)
    }

    func testPeekAlwaysReturnsTopWithoutRemoving() {
        let stack = Stack<Int>()
        
        stack.push(50)
        XCTAssertEqual(stack.peek(), 50)
        XCTAssertEqual(stack.peek(), 50)
        
        stack.push(60)
        XCTAssertEqual(stack.peek(), 60)
        
        _ = stack.pop()
        XCTAssertEqual(stack.peek(), 50)
    }

    func testPushPopSequence_UpdatesSizeCorrectly() {
        let stack = Stack<Int>()
        
        XCTAssertEqual(stack.currentSize, 0)
        
        stack.push(1)
        XCTAssertEqual(stack.currentSize, 1)
        
        stack.push(2)
        XCTAssertEqual(stack.currentSize, 2)
        
        _ = stack.pop()
        XCTAssertEqual(stack.currentSize, 1)
        
        _ = stack.pop()
        XCTAssertEqual(stack.currentSize, 0)
    }

    func testStackWorksWithDifferentTypes() {
        let intStack = Stack<Int>()
        intStack.push(42)
        XCTAssertEqual(intStack.pop(), 42)
        
        let stringStack = Stack<String>()
        stringStack.push("test")
        XCTAssertEqual(stringStack.pop(), "test")
        
        let doubleStack = Stack<Double>()
        doubleStack.push(3.14)
        XCTAssertEqual(doubleStack.pop(), 3.14)
    }

    func testMultipleOperationsOnSameStack() {
        let stack = Stack<Int>()
        
        // Push multiple
        stack.push(10)
        stack.push(20)
        stack.push(30)
        
        // Peek without removing
        XCTAssertEqual(stack.peek(), 30)
        XCTAssertEqual(stack.currentSize, 3)
        
        // Pop some
        XCTAssertEqual(stack.pop(), 30)
        XCTAssertEqual(stack.pop(), 20)
        
        // Push more
        stack.push(40)
        stack.push(50)
        
        // Verify final state
        XCTAssertEqual(stack.currentSize, 3)
        XCTAssertEqual(stack.peek(), 50)
    }
}

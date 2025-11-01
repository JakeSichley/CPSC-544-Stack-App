//
//  CommandParserTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class CommandParserTests: XCTestCase {

    func testMultiplePushesAndPops_MaintainsCorrectOrder() {
        let stack = Stack<Int>()
        
        stack.push(1)
        stack.push(2)
        stack.push(3)
        XCTAssertEqual(stack.currentSize, 3)
        
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.pop(), 2)
        
        stack.push(4)
        XCTAssertEqual(stack.currentSize, 2)
        
        XCTAssertEqual(stack.peek(), 4)
        XCTAssertEqual(stack.pop(), 4)
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.currentSize, 0)
    }

    func testPeekDoesNotModifyStack() {
        let stack = Stack<Int>()
        stack.push(10)
        stack.push(20)
        
        let peek1 = stack.peek()
        let peek2 = stack.peek()
        let peek3 = stack.peek()
        
        XCTAssertEqual(peek1, 20)
        XCTAssertEqual(peek2, 20)
        XCTAssertEqual(peek3, 20)
        XCTAssertEqual(stack.currentSize, 2)
    }

    func testEmptyStackOperations() {
        let stack = Stack<Int>()
        
        XCTAssertNil(stack.pop())
        XCTAssertNil(stack.peek())
        XCTAssertEqual(stack.currentSize, 0)
        
        stack.push(42)
        XCTAssertEqual(stack.currentSize, 1)
        XCTAssertEqual(stack.peek(), 42)
    }

    func testStackWithSingleElement() {
        let stack = Stack<Int>()
        stack.push(100)
        
        XCTAssertEqual(stack.currentSize, 1)
        XCTAssertEqual(stack.peek(), 100)
        XCTAssertEqual(stack.pop(), 100)
        XCTAssertEqual(stack.currentSize, 0)
        XCTAssertNil(stack.pop())
    }
}

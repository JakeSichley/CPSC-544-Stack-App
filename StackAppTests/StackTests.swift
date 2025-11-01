//
//  StackTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class StackTests: XCTestCase {

    func testNewStack_IsEmpty_HasZeroSize() {
        let stack = Stack<Int>()
        XCTAssertEqual(stack.currentSize, 0)
    }

    func testPushAddsElement_IncreasesSize() {
        let stack = Stack<Int>()
        
        stack.push(3)
        XCTAssertEqual(stack.currentSize, 1)
        
        stack.push(5)
        XCTAssertEqual(stack.currentSize, 2)
        
        stack.push(2)
        XCTAssertEqual(stack.currentSize, 3)
    }

    func testPopRemovesTopElement_DecreasesSize_ReturnsValue() {
        let stack = Stack<Int>()
        stack.push(3)
        stack.push(5)
        stack.push(2)
        XCTAssertEqual(stack.currentSize, 3)
        
        let value1 = stack.pop()
        XCTAssertEqual(value1, 2)
        XCTAssertEqual(stack.currentSize, 2)
        
        let value2 = stack.pop()
        XCTAssertEqual(value2, 5)
        XCTAssertEqual(stack.currentSize, 1)
        
        let value3 = stack.pop()
        XCTAssertEqual(value3, 3)
        XCTAssertEqual(stack.currentSize, 0)
    }

    func testPopWhenEmpty_ReturnsNil_SizeUnchanged() {
        let stack = Stack<Int>()
        XCTAssertEqual(stack.currentSize, 0)
        
        let value = stack.pop()
        XCTAssertNil(value)
        XCTAssertEqual(stack.currentSize, 0)
    }

    func testPeekReturnsTopElement_DoesNotRemove_SizeUnchanged() {
        let stack = Stack<Int>()
        stack.push(3)
        stack.push(5)
        stack.push(2)
        
        let peeked1 = stack.peek()
        XCTAssertEqual(peeked1, 2)
        XCTAssertEqual(stack.currentSize, 3)
        
        let peeked2 = stack.peek()
        XCTAssertEqual(peeked2, 2)
        XCTAssertEqual(stack.currentSize, 3)
    }

    func testPeekWhenEmpty_ReturnsNil() {
        let stack = Stack<Int>()
        XCTAssertNil(stack.peek())
    }

    func testInitWithElements_CreatesStackWithThoseElements() {
        let stack = Stack<Int>([3, 5, 2])
        XCTAssertEqual(stack.currentSize, 3)
        
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.pop(), 3)
    }

    func testStackWorksWithStrings() {
        let stack = Stack<String>()
        stack.push("hello")
        stack.push("world")
        
        XCTAssertEqual(stack.currentSize, 2)
        XCTAssertEqual(stack.peek(), "world")
        XCTAssertEqual(stack.pop(), "world")
        XCTAssertEqual(stack.pop(), "hello")
    }
}

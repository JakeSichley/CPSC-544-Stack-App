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



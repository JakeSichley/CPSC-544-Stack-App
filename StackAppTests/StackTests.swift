//
//  StackTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class StackTests: XCTestCase {

    func testNewStack_IsEmpty_NotFull_ContentsEmpty() {
        let stack = Stack(maxSize: 3)
        XCTAssertTrue(stack.isEmpty)
        XCTAssertFalse(stack.isFull)
        XCTAssertEqual(stack.contents, [])
    }

    func testPushWithinCapacity_AddsToTop_UpdatesFlagsAndContents() {
        var stack = Stack(maxSize: 3)

        let r1 = stack.push(3)
        XCTAssertEqual(r1, .pushed(3))
        XCTAssertEqual(stack.contents, [3])
        XCTAssertFalse(stack.isEmpty)
        XCTAssertFalse(stack.isFull)

        let r2 = stack.push(5)
        XCTAssertEqual(r2, .pushed(5))
        XCTAssertEqual(stack.contents, [3, 5])
        XCTAssertFalse(stack.isEmpty)
        XCTAssertFalse(stack.isFull)

        let r3 = stack.push(2)
        XCTAssertEqual(r3, .pushed(2))
        XCTAssertEqual(stack.contents, [3, 5, 2])
        XCTAssertFalse(stack.isEmpty)
        XCTAssertTrue(stack.isFull)
    }

    func testPushWhenFull_DoesNotMutate_ReturnsFull() {
        var stack = Stack(maxSize: 3)
        _ = stack.push(3)
        _ = stack.push(5)
        _ = stack.push(2)
        XCTAssertTrue(stack.isFull)
        XCTAssertEqual(stack.contents, [3, 5, 2])

        let r = stack.push(7)
        XCTAssertEqual(r, .full)
        XCTAssertEqual(stack.contents, [3, 5, 2]) // unchanged
        XCTAssertTrue(stack.isFull)
    }

    func testPopFromNonEmpty_PopsTop_UpdatesFlagsAndContents() {
        var stack = Stack(maxSize: 3)
        _ = stack.push(3)
        _ = stack.push(5)
        _ = stack.push(2)

        let r1 = stack.pop()
        XCTAssertEqual(r1, .popped(2))
        XCTAssertEqual(stack.contents, [3, 5])
        XCTAssertFalse(stack.isEmpty)
        XCTAssertFalse(stack.isFull)

        let r2 = stack.pop()
        XCTAssertEqual(r2, .popped(5))
        XCTAssertEqual(stack.contents, [3])

        let r3 = stack.pop()
        XCTAssertEqual(r3, .popped(3))
        XCTAssertEqual(stack.contents, [])
        XCTAssertTrue(stack.isEmpty)
        XCTAssertFalse(stack.isFull)
    }

    func testPopWhenEmpty_DoesNotMutate_ReturnsEmpty() {
        var stack = Stack(maxSize: 3)
        XCTAssertTrue(stack.isEmpty)

        let r = stack.pop()
        XCTAssertEqual(r, .empty)
        XCTAssertEqual(stack.contents, [])
        XCTAssertTrue(stack.isEmpty)
    }
}

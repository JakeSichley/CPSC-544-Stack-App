//
//  OutputFormattingTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class OutputFormattingTests: XCTestCase {

    func testRenderStackFormatsBottomToTop_WithSpacesAndEmptyCase() {
        XCTAssertEqual(OutputFormatter.renderStack([]), "Stack [ ]")
        XCTAssertEqual(OutputFormatter.renderStack([3]), "Stack [3]")
        XCTAssertEqual(OutputFormatter.renderStack([3, 5]), "Stack [3 5]")
        XCTAssertEqual(OutputFormatter.renderStack([3, 5, 2]), "Stack [3 5 2]")
    }

    func testFormatPushMessages() {
        // start with [3]
        let contents1 = [3]
        XCTAssertEqual(
            OutputFormatter.formatPush(.pushed(3), contents: contents1),
            "3 is pushed. Stack [3]"
        )

        // full case with [3 5 2]
        let contentsFull = [3, 5, 2]
        XCTAssertEqual(
            OutputFormatter.formatPush(.full, contents: contentsFull),
            "Stack is FULL. Stack [3 5 2]"
        )
    }

    func testFormatPopMessages() {
        // popped 2 -> [3 5]
        let contentsAfterPop = [3, 5]
        XCTAssertEqual(
            OutputFormatter.formatPop(.popped(2), contents: contentsAfterPop),
            "2 is popped. Stack [3 5]"
        )

        // empty case -> [ ]
        XCTAssertEqual(
            OutputFormatter.formatPop(.empty, contents: []),
            "Stack is EMPTY. Stack [ ]"
        )
    }

    func testFormatQuitMessage() {
        XCTAssertEqual(OutputFormatter.formatQuit(), "Exit from the application.")
    }

    func testFormatParseErrorIncludesCurrentStack() {
        XCTAssertEqual(
            OutputFormatter.formatParseError("Invalid number. Enter 0–9.", contents: [3, 5, 2]),
            "Invalid number. Enter 0–9. Stack [3 5 2]"
        )

        XCTAssertEqual(
            OutputFormatter.formatParseError("Invalid input. Enter 'push n', 'pop', or 'quit'.", contents: []),
            "Invalid input. Enter 'push n', 'pop', or 'quit'. Stack [ ]"
        )
    }
}

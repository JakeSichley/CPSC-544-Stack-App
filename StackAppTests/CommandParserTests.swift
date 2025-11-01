//
//  CommandParserTests.swift
//  StackAppTests
//
//  Created by Homework TDD
//

import XCTest
@testable import StackApp

final class CommandParserTests: XCTestCase {

    func testParsesPushWithValidSingleDigit_AnySpacing_CaseInsensitive() {
        let inputs = [
            "push 3",
            " PUSH 3 ",
            "  push    3  ",
            "\tpush\t3\n"
        ]
        for input in inputs {
            let result = CommandParser.parse(input)
            XCTAssertEqual(result, .success(.push(3)))
        }
    }

    func testParsesPopAndQuit_CaseInsensitive_WithWhitespace() {
        XCTAssertEqual(CommandParser.parse("pop"), .success(.pop))
        XCTAssertEqual(CommandParser.parse(" POP "), .success(.pop))
        XCTAssertEqual(CommandParser.parse("quit"), .success(.quit))
        XCTAssertEqual(CommandParser.parse("  QuiT  "), .success(.quit))
    }

    func testPushOutOfRange_ReturnsInvalidNumber() {
        XCTAssertEqual(CommandParser.parse("push 10"), .failure("Invalid number. Enter 0–9."))
        XCTAssertEqual(CommandParser.parse("push -1"), .failure("Invalid number. Enter 0–9."))
    }

    func testBadFormats_ReturnsGenericInvalidInput() {
        let badInputs = [
            "push",          // missing value
            "push x",        // non-numeric
            "push 3 4",      // extra token
            "puhs 3",        // misspelled command
            "hello world",   // unknown
            "",              // empty
            "   "            // whitespace only
        ]
        for input in badInputs {
            let result = CommandParser.parse(input)
            XCTAssertEqual(result, .failure("Invalid input. Enter 'push n', 'pop', or 'quit'."),
                           "Input '\(input)' should fail with generic invalid input message")
        }
    }

    func testTrimsAndNormalizesWhitespace() {
        XCTAssertEqual(CommandParser.parse("  push    9  "), .success(.push(9)))
        XCTAssertEqual(CommandParser.parse("\n pop \t"), .success(.pop))
    }
}

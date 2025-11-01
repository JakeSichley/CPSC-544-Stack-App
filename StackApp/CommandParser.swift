//
//  CommandParser.swift
//  StackApp
//

import Foundation

public enum Command: Equatable {
    case push(Int)
    case pop
    case quit
}

public enum CommandParseResult: Equatable {
    case success(Command)
    case failure(String)
}

public enum CommandParser {

    // Parses commands case-insensitively, tolerates extra whitespace.
    // Accepts: "push n" where n ∈ 0...9, "pop", "quit"
    public static func parse(_ input: String) -> CommandParseResult {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
        }

        let tokens = trimmed
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }

        guard let first = tokens.first?.lowercased() else {
            return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
        }

        switch first {
        case "push":
            guard tokens.count == 2, let n = Int(tokens[1]) else {
                return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
            }
            guard (0...9).contains(n) else {
                return .failure("Invalid number. Enter 0–9.")
            }
            return .success(.push(n))

        case "pop":
            guard tokens.count == 1 else {
                return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
            }
            return .success(.pop)

        case "quit":
            guard tokens.count == 1 else {
                return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
            }
            return .success(.quit)

        default:
            return .failure("Invalid input. Enter 'push n', 'pop', or 'quit'.")
        }
    }
}

//
//  OutputFormatter.swift
//  StackApp
//

import Foundation

public enum OutputFormatter {

    public static func renderStack(_ contents: [Int]) -> String {
        if contents.isEmpty {
            return "Stack [ ]"
        }
        let body = contents.map(String.init).joined(separator: " ")
        return "Stack [\(body)]"
    }

    public static func formatPush(_ outcome: PushOutcome, contents: [Int]) -> String {
        switch outcome {
        case .pushed(let n):
            return "\(n) is pushed. \(renderStack(contents))"
        case .full:
            return "Stack is FULL. \(renderStack(contents))"
        }
    }

    public static func formatPop(_ outcome: PopOutcome, contents: [Int]) -> String {
        switch outcome {
        case .popped(let n):
            return "\(n) is popped. \(renderStack(contents))"
        case .empty:
            return "Stack is EMPTY. \(renderStack(contents))"
        }
    }

    public static func formatQuit() -> String {
        "Exit from the application."
    }

    public static func formatParseError(_ message: String, contents: [Int]) -> String {
        "\(message) \(renderStack(contents))"
    }
}

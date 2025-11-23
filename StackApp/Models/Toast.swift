import Foundation

public enum Toast {
    
    public enum ToastType {
        case success
        case error
    }
    
    // MARK: - Cases
    
    case push(Int)
    case pop(Int)
    
    case pushWhenFull
    case popWhenEmpty
    case invalidInput
    
    // MARK: - Properties
    
    public var message: String {
        switch self {
        case .push(let value):
            return "Pushed \(value)"
        case .pop(let value):
            return "Popped \(value)"
        case .pushWhenFull:
            return "Cannot push element - stack is full!"
        case .popWhenEmpty:
            return "Cannot pop element - stack is empty!"
        case .invalidInput:
            return "Cannot add element - value must be a digit between 0-9!"
        }
    }
    
    public var type: ToastType {
        switch self {
        case .push:
            return .success
        case .pop:
            return .success
        case .pushWhenFull:
            return .error
        case .popWhenEmpty:
            return .error
        case .invalidInput:
            return .error
        }
    }
}

// MARK: - IdentifiableContent + Toast

internal extension [IdentifiableContent<Toast>] {
    mutating func append(_ toast: Toast) {
        append(.init(toast))
    }
}

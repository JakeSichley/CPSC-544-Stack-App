import SwiftUI

@Observable @MainActor
public final class StackViewModel {
    
    // MARK: - Properties
    
    public var contents: [IdentifiableContent<Int>] {
        stack.contents
    }
    
    public var isEmpty: Bool {
        stack.isEmpty
    }
    
    public var isFull: Bool {
        stack.currentSize >= maxSize
    }
    
    public var inputValue: String = ""
    
    public private(set) var toasts: [IdentifiableContent<Toast>] = [] {
        didSet {
            if toasts.count > 3 {
                toasts = toasts.suffix(3)
            }
            
            Task {
                guard let newValue = toasts.last else { return }
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                
                withAnimation {
                    toasts.removeAll { $0.id == newValue.id }
                }
            }
        }
    }
    
    private var stack: Stack<Int>
    
    public let maxSize: Int = 3
    
    // MARK: - Lifecycle
    
    public init() {
        self.stack = .init()
    }
    
    // MARK: - Tasks
    
    public func pop() {
        guard stack.isNotEmpty else {
            withAnimation {
                toasts.append(.popWhenEmpty)
            }
            return
        }
        
        withAnimation {
            let value = stack.pop()!
            toasts.append(.pop(value))
        }
    }
    
    public func push() {
        guard stack.currentSize < maxSize else {
            withAnimation {
                toasts.append(.pushWhenFull)
            }
            return
        }
        
        guard let value = Int(inputValue) else {
            withAnimation {
                toasts.append(.invalidInput)
            }
            return
        }
        
        withAnimation {
            stack.push(value)
            toasts.append(.push(value))
        }
        
        inputValue = ""
    }
    
    // MARK: - Observation
    
    func inputOnChange() {
        if inputValue.count > 1 {
            inputValue = String(inputValue.suffix(1))
        }
    }
}

import SwiftUI

public struct ToastView: View {
    
    // MARK: - Properties
    
    private let toast: Toast
    
    private var borderColor: Color {
        switch toast.type {
        case .success:
            return .green
        case .error:
            return .red
        }
    }
    
    // MARK: - Lifecycle
    
    public init(_ toast: Toast) {
        self.toast = toast
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: .x0_5) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
            
            Text(toast.message)
                .font(.caption)
                .foregroundColor(.black)
        }
        .padding(.horizontal, .x1)
        .padding(.vertical, .x1)
        .background(
            RoundedRectangle(cornerRadius: .x2)
                .fill(.white)
                .strokeBorder(borderColor, lineWidth: 1)
        )
        .transition(
            .asymmetric(
                insertion: .push(from: .bottom),
                removal: .opacity
            )
        )
    }
    
    // MARK: - Components
    
    private var image: Image {
        switch toast.type {
        case .success:
            Image(.success)
        case .error:
            Image(.error)
        }
    }
}

#Preview {
    ToastView(.popWhenEmpty)
}

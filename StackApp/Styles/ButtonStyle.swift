import SwiftUI

public struct StackAppButtonStyle: ButtonStyle {
    
    // MARK: - Properties
    
    private let style: ButtonStyle
    private let size: ButtonSize
    
    // MARK: - Lifecycle
    
    public init(style: ButtonStyle = .secondary, size: ButtonSize = .large) {
        self.style = style
        self.size = size
    }
    
    // MARK: - makeBody
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, size.verticalPadding)
            .padding(.horizontal, size.horizontalPadding)
            .foregroundStyle(style.textColor)
            .background(style.backgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(style.borderColor, lineWidth: 1)
            )
            .contentShape(Rectangle())
    }
    
    // MARK: - ButtonStyle
    
    public enum ButtonStyle {
        
        // MARK: - Cases
        
        case primary
        case secondary
        case secondaryWhite
        case secondaryWhiteWithoutBorder
        case text
        case disabled
        case disabledSecondary
        case destructivePrimary
        case destructive
        case automatic
        
        // MARK: - Properties
        
        public var backgroundColor: some View {
            switch self {
            case .primary:
                return Color.titanOrange
            case .secondary:
                return Color.clear
            case .secondaryWhite, .secondaryWhiteWithoutBorder:
                return Color.white
            case .text:
                return Color.clear
            case .disabled:
                return Color.gray
            case .disabledSecondary:
                return Color.white
            case .destructivePrimary:
                return Color.red
            case .destructive:
                return Color.clear
            case .automatic:
                return Color.clear
            }
        }
        
        public var textColor: Color {
            switch self {
            case .primary:
                return Color(.systemBackground)
            case .secondary, .secondaryWhite, .secondaryWhiteWithoutBorder:
                return Color.titanOrange
            case .text:
                return Color.titanOrange
            case .disabled:
                return Color.gray
            case .disabledSecondary:
                return Color.gray
            case .destructivePrimary:
                return Color.white
            case .destructive:
                return Color.red
            case .automatic:
                return Color.titanBlue
            }
        }
        
        public var borderColor: Color {
            switch self {
            case .primary, .secondaryWhiteWithoutBorder:
                return Color.clear
            case .secondary, .secondaryWhite:
                return Color.titanOrange
            case .text:
                return Color.clear
            case .disabled:
                return Color.clear
            case .disabledSecondary:
                return Color.gray
            case .destructivePrimary:
                return Color.white
            case .destructive:
                return Color.red
            case .automatic:
                return Color.clear
            }
        }
    }
    
    // MARK: - ButtonSize
    
    public enum ButtonSize {
        
        // MARK: - Cases
        
        case small
        case medium
        case large
        
        // MARK: - Properties
        
        public var verticalPadding: CGFloat {
            switch self {
            case .large: return .x1_5
            case .medium: return .x1
            case .small: return .x0_5
            }
        }
        
        public var horizontalPadding: CGFloat {
            switch self {
            case .large: return .x1_5
            case .medium: return .x2_5
            case .small: return .x0_5
            }
        }
    }
}

// MARK: - View + buttonStyle

extension View {
    public func buttonStyle(
        _ style: StackAppButtonStyle.ButtonStyle = .primary,
        size: StackAppButtonStyle.ButtonSize = .medium,
    ) -> some View {
        buttonStyle(StackAppButtonStyle(style: style, size: size))
    }
}

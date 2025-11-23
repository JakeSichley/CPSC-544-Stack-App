import SwiftUI

public struct StackView: View {
    
    // MARK: - Properties
    
    @State private var viewModel: StackViewModel = .init()
    @FocusState private var focusState: Bool
    @Namespace private var namespace
    
    private let animationOffset = UIScreen.main.bounds.size.height * 0.85
    
    private var transition: AnyTransition {
        .asymmetric(
            insertion: .offset(x: 0, y: -animationOffset),
            removal: .offset(x: 0, y: -animationOffset)
        )
    }
    
    // MARK: - Components
    
    private func headerView() -> some View {
        HStack(alignment: .bottom, spacing: .zero) {
            Image(.tuffyCharging)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .padding(.trailing, -.x0_5)
            
            Text("StackApp")
                .font(.largeTitle)
                .foregroundStyle(.text)
                .bold()
                .fixedSize()
            
            Spacer()
            
            quitButtonView()
        }
    }
    
    @ViewBuilder
    private func stackLabelView(_ label: String, condition: Bool = true) -> some View {
        if condition {
            Text(label)
                .font(.subheadline)
                .frame(height: 20)
                .padding(.x1)
                .background(.beige)
                .foregroundColor(.text)
                .overlay(
                    RoundedRectangle(cornerRadius: .x1)
                        .strokeBorder(.text, lineWidth: 1)
                )
                .cornerRadius(.x1)
                .transition(transition)
        }
    }
    
    private func stackElementView<T>(_ element: IdentifiableContent<T>) -> some View {
        Text("\(element.value)")
            .font(.subheadline)
            .foregroundColor(.text)
            .frame(width: 100, height: 40)
            .background(Color.titanOrange)
            .cornerRadius(.x1)
            .overlay(
                RoundedRectangle(cornerRadius: .x1)
                    .strokeBorder(.text, lineWidth: 1)
                    .shadow(color: .gray.opacity(0.2), radius: .x4, x: 0, y: .x0_5)
            )
            .id(element.id)
            .transition(transition)
            .frame(maxWidth: .infinity)
    }
    
    private func digitInputView() -> some View {
        TextField("Enter a digit 0-9", text: $viewModel.inputValue)
            .keyboardType(.numberPad)
            .foregroundStyle(.text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(
                RoundedRectangle(cornerRadius: .x1)
                    .strokeBorder(.text.opacity(0.5), lineWidth: 1)
            )
            .focused($focusState, equals: true)
            .onSubmit {
                viewModel.push()
                focusState = true
                
            }
            .onChange(of: viewModel.inputValue) {
                viewModel.inputOnChange()
            }
    }
    
    private func quitButtonView() -> some View {
        Button("Quit", role: .destructive) {
            exit(EXIT_SUCCESS)
        }
        .buttonStyle(.destructivePrimary, size: .medium)
    }
    
    private func pushButtonView() -> some View {
        Button("Push") {
            viewModel.push()
        }
        .buttonStyle(.primary, size: .medium)
    }
    
    private func popButtonView() -> some View {
        Button("Pop", role: .cancel) {
            viewModel.pop()
        }
        .buttonStyle(.secondary, size: .medium)
    }
    
    private func actionOverlay() -> some View {
        HStack(spacing: .x1) {
            digitInputView()
                .padding(.trailing, .x1)
            
            Spacer()
            
            pushButtonView()
            popButtonView()
        }
        .padding(.top, .x3)
        .padding(.horizontal, .x2)
        .padding(.bottom, .x1)
        .background(.skyBlue)
    }
    
    @ViewBuilder
    private func stackContent() -> some View {
        if viewModel.isEmpty {
            stackLabelView("Stack is Empty")
        } else {
            ForEach(viewModel.contents.reversed(), id: \.id) { element in
                stackElementView(element)
            }
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: .x3) {
            headerView()
            
            Spacer()
            
            VStack(spacing: .x2) {
                stackLabelView("Top of Stack", condition: !viewModel.isEmpty)
                stackContent()
                stackLabelView("Bottom of Stack", condition: !viewModel.isEmpty)
            }
            
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.x2)
        .padding(.vertical, .x2)
        .frame(width: UIScreen.main.bounds.size.width)
        .background(.titanOrange.opacity(0.2))
        .overlay(alignment: .bottom) {
            VStack(spacing: .x1) {
                ForEach(viewModel.toasts, id: \.id) { toast in
                    ToastView(toast.value)
                }
                
                actionOverlay()
            }
        }
    }
}

#Preview {
    StackView()
}

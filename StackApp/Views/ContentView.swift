//
//  ContentView.swift
//  StackApp
//
//  Created by Jake Sichley on 10/27/25.
//
import SwiftUI

struct ContentView: View {
    @State private var stack: [Int] = []
    @State private var inputValue: String = ""
    @State private var message: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("🧱 Stack App 🧱")
                .font(.largeTitle)
                .bold()

            // Stack visualized from bottom to top
            VStack {
                Text("Stack (max size = 3)")
                    .font(.headline)

                // Show stack elements bottom to top
                VStack(spacing: 10) {
                    ForEach(stack.indices.reversed(), id: \.self) { index in
                        Text("\(stack[index])")
                            .frame(width: 60, height: 40)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .frame(height: 150)
                .padding()
                .border(Color.gray)
            }

            // Input field restricted to single digit 0-9
            TextField("Enter a digit 0-9", text: $inputValue)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: inputValue) { newValue in
                    // Allow only one digit 0-9
                    if let firstChar = newValue.first, newValue.count == 1, firstChar.isNumber {
                        // Valid input: keep it
                        inputValue = String(firstChar)
                    } else {
                        // Invalid input: clear or revert to previous valid state
                        inputValue = ""
                    }
                }

            // Buttons
            HStack(spacing: 20) {
                Button("Push") {
                    guard let number = Int(inputValue) else {
                        message = "Please enter a single digit 0-9."
                        return
                    }

                    if stack.count < 3 {
                        stack.append(number)
                        inputValue = ""
                        message = ""
                    } else {
                        message = "Stack is full!"
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Pop") {
                    if !stack.isEmpty {
                        _ = stack.removeLast()
                        message = ""
                    } else {
                        message = "Stack is empty!"
                    }
                }
                .buttonStyle(.bordered)

                Button("Quit") {
                    stack.removeAll()
                    inputValue = ""
                    message = "Stack cleared."
                }
                .foregroundColor(.red)
            }

            // Status message
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.gray)
                    .italic()
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

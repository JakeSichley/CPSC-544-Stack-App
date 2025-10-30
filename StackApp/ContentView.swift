//
//  ContentView.swift
//  StackApp
//
//  Created by Jake Sichley on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stack: [Int] = []
    
    var body: some View {
        ScrollView([.vertical]) {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Button("Push") {
                        stack.append(Int.random(in: 0...100))
                    }
                    
                    Button("Pop") {
                        _ = stack.popLast()
                    }
                }
                
                Text("Stack")
                    .font(.headline)
                
                ForEach(stack.reversed(), id: \.self) { element in
                    Text("\(element)")
                    Divider()
                }
            }
        }
        .padding(32)
    }
}

#Preview {
    ContentView()
}

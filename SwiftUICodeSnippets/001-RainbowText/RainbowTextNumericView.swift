//
//  RainbowTextNumericView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//

import SwiftUI

struct RainbowTextNumericView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        Text("Welcome to SwiftUI! \(counter)")
            .font(.title)
            .foregroundStyle(
                .linearGradient(
                    colors: [.red, .green, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .contentTransition(.numericText(value: Double(counter)))
            .onTapGesture {
                withAnimation {
                    counter += 1
                }
            }
    }
}

#Preview {
    RainbowTextNumericView()
}

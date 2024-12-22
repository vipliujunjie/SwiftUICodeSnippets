//
//  ScaledButtonStyle.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.interactiveSpring(), value: configuration.isPressed)
    }
}

#Preview {
    Button {
        //
    } label: {
        Text("Hello, world")
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .clipShape(.capsule)
    }
    .buttonStyle(ScaledButtonStyle())
    .padding()
}

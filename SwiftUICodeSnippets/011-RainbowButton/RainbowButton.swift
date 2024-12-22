//
//  RainbowButton.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/11.
//


import SwiftUI

struct RainbowButton: View {
    var body: some View {
        let backgroundColor = Color("DarkBlue")
        Button {
            //
        } label: {
            Text("Hello, world")
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .foregroundStyle(
                    .linearGradient(
                        colors: [
                            .indigo,
                            .purple,
                            .pink,
                            .orange,
                            .yellow,
                            .green
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .background(backgroundColor)
                .cornerRadius(8)
                .shadow(
                    color: backgroundColor.opacity(0.5),
                    radius: 2,
                    x: 0,
                    y: 1
                )
                .shadow(
                    color: backgroundColor.opacity(0.5),
                    radius: 16,
                    x: 0,
                    y: 4
                )
        }
        .buttonStyle(ScaledButtonStyle())
    }
}

// 把我们之前实现的 ScaledButtonStyle 粘贴过来
extension RainbowButton {
    private struct ScaledButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .scaleEffect(configuration.isPressed ? 0.9 : 1)
                .animation(.interactiveSpring(), value: configuration.isPressed)
        }
    }
}

#Preview {
    RainbowButton()
        .offset(y: -100)
}

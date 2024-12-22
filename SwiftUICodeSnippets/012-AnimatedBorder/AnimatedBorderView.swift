//
//  AnimatedBorderView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/14.
//


import SwiftUI

struct AnimatedBorderView: View {
    var body: some View {
        Image("background-2")
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .overlay {
                AnimatedBorder()
            }
    }
}

struct AnimatedBorder: View {
    @State private var rotation: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(
                    .linearGradient(
                        colors: [
                            .indigo.opacity(0.3),
                            .indigo,
                            .indigo.opacity(0.3)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                // 为了实现对角线出现部分 border 的效果, 需要将宽度减半, 高度增加一倍
                // 这样矩形旋转起来的时候才会看到 border 旋转的效果
                .frame(
                    width: proxy.size.width / 2,
                    height: proxy.size.height * 2
                )
                // 需要改变 position, 才能将 GeometryReader 中的 View 居中
                .position(
                    x: proxy.frame(in: .local).width / 2,
                    y: proxy.frame(in: .local).height / 2
                )
                // 将矩形转起来
                .rotationEffect(.degrees(rotation))
                // 动画时间为 4s, 永不停止
                .animation(
                    .linear(duration: 4).repeatForever(
                        autoreverses: false
                    ),
                    value: rotation
                )
                // 使用 mask 裁剪矩形的中间部分, 只保留边框为 4 的线
                .mask {
                    Rectangle()
                        .stroke(lineWidth: 4)
                }
                .onAppear {
                    // 让矩形旋转 360
                    rotation = 360
                }
        }
    }
}

#Preview {
    AnimatedBorderView()
        .offset(x: 0, y: -100)
}

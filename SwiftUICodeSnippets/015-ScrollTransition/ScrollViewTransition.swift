//
//  ScrollViewTransition.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/16.
//


import SwiftUI

struct ScrollViewTransition: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(1..<6) { index in
                    // 增加一个动态的视觉效果
                    // 使用 ZStack 包裹 Image 为了让 Image 动起来
                    // 容器层不发生变化
                    ZStack {
                        Image("image-\(index)")
                            .resizable()
                            .scaledToFill()
                            .scrollTransition { content, phase in
                                // phase 为当前 image 的出现阶段
                                // -1 位于最左侧, 0 位于居中, 1 位于最右侧
                                content
                                    .offset(x: phase.value * 200)
                            }
                    }
                    // 让图片的 Size 根据 ScrollView 展示的区域来决定
                    .containerRelativeFrame(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 36))
                }
            }
        }
        // 设置 ScrollView 为分页模式
        .scrollTargetBehavior(.paging)
        // 这里需要保证左右的 margin 是 HStack 中 spacing 16 的 2 倍
        // 才能达到中间的图片是居中的状态
        .contentMargins(32)
        // 我们将 ScrollView 改小一点, 这样效果不太好
        .frame(height: 600)
    }
}

#Preview {
    ScrollViewTransition()
}

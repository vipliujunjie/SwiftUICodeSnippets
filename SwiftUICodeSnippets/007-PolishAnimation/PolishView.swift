//
//  PolishView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/9.
//

import SwiftUI

struct PolishView: View {
    @State private var trigger = false
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .overlay {
                // 100 比较 hardcode 我们动态获取视图的高度
                GeometryReader { proxy in
                    let size = proxy.size
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0),
                            Color.white.opacity(0),
                            Color.white.opacity(0),
                            Color.white.opacity(0.8),
                            Color.white.opacity(0),
                            Color.white.opacity(0),
                            Color.white.opacity(0),
                        ],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                    // 渐变视图左右两侧会出现露出缺角
                    // 我们放大 2 倍的 size, 避免出现这种情况
                    .scaleEffect(2)
                    .keyframeAnimator(
                        initialValue: 0,
                        trigger: trigger,
                        content: { content, progress in
                            // 我们需要将渐变色从 View 底部移动到 View 右上角
                            content
                                .offset(
                                    // 当 progress 从 0 到 1 的时候
                                    // offset 的 x 和 y 分别会趋近于 0
                                    // 偏移的距离还不够, 我们改为 2 倍
                                    x: -size.width + progress * size.width * 2,
                                    y: size.height - progress * size.height * 2
                                )
                        },
                        keyframes: { _ in
                            CubicKeyframe(0, duration: 0)
                            CubicKeyframe(1, duration: 1)
                        }
                    )
                }
            }
            .onTapGesture {
                trigger.toggle()
            }
            .frame(width: 200, height: 200)
            .cornerRadius(24)
    }
}

#Preview {
    PolishView()
}

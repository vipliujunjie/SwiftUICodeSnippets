//
//  MeshGradientView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/17.
//


import SwiftUI

struct MeshGradientView: View {
    
    // 我们来创建一个动画, MeshGradient 是支持动画效果的
    @State private var toggle: Bool = false
    
    // 由于创建的是 3*3 的网格, 因此我们需要 9 个点
    var points: [SIMD2<Float>] {
        [
            [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
            [0.0, 0.5], [toggle ? 1 : 0.0, 0.5], [1.0, 0.5],
            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
        ]
    }
    
    // 同样从左上角顺时针转一圈, 创建 9 个颜色
    // (分别是彩虹的颜色, 中间用白色填充)
    var colors: [Color] {
        [
            // 这里我先用白色填充, 方便按彩虹的颜色顺序更改
            .red, .orange, .yellow,
            .purple, .white, .green,
            .indigo, .blue, .mint,
        ]
    }
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: points,
            colors: colors
        )
        // 忽略安全区
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                toggle.toggle()
            }
        }
    }
}

#Preview {
    MeshGradientView()
}

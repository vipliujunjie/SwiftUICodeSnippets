//
//  NumericAnimationView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/20.
//

import SwiftUI

struct NumericAnimationView: View {
    // 维护展示在屏幕上的文本 & 颜色
    @State private var index = 0
    // 每一个标题对应一种颜色
    let colors: [Color] = [.red, .orange, .green, .blue]
    let titles = ["Hello", "SwiftUI", "你好", "SwiftUI"]
    
    var body: some View {
        let color = colors[index]
        return Text(titles[index])
            .font(.system(size: 80, weight: .thin))
            // 增加阴影效果
            .shadow(color: color, radius: 5)
            .shadow(color: color, radius: 5)
            .shadow(color: color, radius: 50)
            .shadow(color: color, radius: 100)
            .shadow(color: color, radius: 200)
            .contentTransition(.numericText())
            .animation(.bouncy, value: index)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                    // 每次 index + 1, 取 colors 的余数防止数组越界
                    // index + 1 == colors.count 时结果为 0
                    index = (index + 1) % colors.count
                }
            }
    }
}

#Preview {
    NumericAnimationView()
}

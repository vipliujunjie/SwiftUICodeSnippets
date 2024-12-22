//
//  FunnyToggleView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/14.
//

import SwiftUI

struct FunnyToggleView: View {
    // 用来管理 Toggler 是否打开的状态
    @State private var isOn: Bool = false
    private let indicatorSize: CGFloat = 30
    // 让 indicator 和背景有一些间距, 这里默认是 4
    private let insetPadding: CGFloat = 4
    private var toggleHeight: CGFloat {
        // 由于是上下都有边距, 这里需要 x2
        indicatorSize + insetPadding * 2
    }
    
    var body: some View {
        UnevenRoundedRectangle(
            // 增加一些有意思的圆角变化效果
            cornerRadii: .init(
                topLeading: isOn ? indicatorSize / 2 : 4,
                // 制造最大的圆角效果
                bottomLeading: indicatorSize / 2,
                bottomTrailing: isOn ? 4 : indicatorSize / 2,
                topTrailing: indicatorSize / 2
            )
        )
        // Indicator 设置开启为白色, 关闭时黄色
        .fill(isOn ? Color.white : Color.yellow)
        // 增加一个黑色边框效果
        .stroke(Color.darkBlue, lineWidth: 2)
        .frame(width: indicatorSize, height: indicatorSize)
        // 设置左右边距
        .padding(.horizontal, insetPadding)
        // 绘制整体的 toggle 背景
        .frame(
            width: indicatorSize * 2.5,
            height: toggleHeight,
            // 开启后让 indicator 回到右侧, 关闭在左侧
            alignment: isOn ? .trailing : .leading
        )
        .background {
            // 同样绘制一个部分圆角效果的矩形
            UnevenRoundedRectangle(
                // 同样背景也设置一样的效果
                cornerRadii: .init(
                    topLeading: isOn ? toggleHeight / 2 : 4,
                    // 制造最大的圆角效果
                    bottomLeading: toggleHeight / 2,
                    bottomTrailing: isOn ? 4 : toggleHeight / 2,
                    topTrailing: toggleHeight / 2
                )
            )
            // 设置开启时背景为黄色, 关闭时白色
            .fill(isOn ? Color.yellow : Color.white)
        }
        .onTapGesture {
            // 点击切换 开/关 状态
            // 增加一些动画
            withAnimation(.easeInOut(duration: 0.5)) {
                isOn.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkBlue)
    }
}

#Preview {
    FunnyToggleView()
        .offset(x: 0, y: -100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkBlue)
}

//
//  WaveShape.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/30.
//

import SwiftUI

/// 这个是让 Cursor 帮我绘制的一个 Shape
/// 顶部是一条曲线, 然后剩下的 3 条边和 Rectangle 没有缺别
struct WaveShape: Shape {
    // 控制曲线的幅度
    var waveRange: CGFloat
    // 0~1, 1 的话 Shape 填充整个屏幕, 0 则只有最底部会有一点点曲线
    var waveHeight: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(waveRange, waveHeight)
        }
        set {
            waveRange = newValue.first
            waveHeight = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 计算实际高度（waveHeight 是 0~1 的比例）
        let actualHeight = rect.maxY * (1 - waveHeight)
        
        // 从左下角开始
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // 画左边和上边的凹陷
        path.addLine(to: CGPoint(x: rect.minX, y: actualHeight))
        
        // 画凹进去的顶边（使用二次贝塞尔曲线）
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: actualHeight),
            control: CGPoint(x: rect.width / 2, y: actualHeight - waveRange)
        )
        
        // 画右边和底边
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    // 改个数字测试下看看效果
    WaveShape(waveRange: -50, waveHeight: 1)
        .fill(Color.indigo)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
}

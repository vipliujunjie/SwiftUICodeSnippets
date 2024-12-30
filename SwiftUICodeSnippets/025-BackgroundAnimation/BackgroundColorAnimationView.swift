//
//  BackgroundColorAnimationView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/30.
//

import SwiftUI

// 我们创建一个 struct 控制 wave 的 height 和 range
struct AnimationValues {
    // 一开始为 -100, 也就是凹进去的效果
    var waveRange: CGFloat = -100
    // 一开始是 0 的 height, 动画开始后变为 0.3 的屏幕高度
    var waveHeight: CGFloat = 0
}

enum AnimationPhase {
    case phase1
    case phase2
    case phase3
}

struct BackgroundColorAnimationView: View {
    @State private var triggerFirstAnimation = false
    // 控制是否开始第二阶段动画
    @State private var triggerSecondAnimation = false
    // 用 enum 维护 animation 进行的阶段
    @State private var animationPhase: AnimationPhase = .phase1
    
    var body: some View {
        ZStack {
            Color.white
            // 老的 View (第一阶段的)
            // 绘制一个从顶部到底部红色的渐变背景
            LinearGradient(
                colors: [
                    Color.red.opacity(0.5),
                    Color.red.opacity(0.8)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            // 忽略安全区
            .ignoresSafeArea()
            // 利用 keyframeAnimator 实现动画效果
            .keyframeAnimator(
                initialValue: AnimationValues(),
                trigger: triggerFirstAnimation,
                content: { content, value in
                    // 我们使用绘制好的 waveShape 裁剪红色渐变背景
                    content.mask {
                        WaveShape(
                            waveRange: value.waveRange,
                            waveHeight: value.waveHeight
                        )
                        // 忽略 mask 的安全区
                        .ignoresSafeArea()
                    }
                },
                keyframes: { _ in
                    // 设置动画
                    // 根据 AnimationValues 中的 key 来做动画
                    // 1. waveRange (也就是顶部的曲线变化)
                    KeyframeTrack(\.waveRange) {
                        // 改为 100 -> -50 -> 25 -> 0 制造波动的效果
                        SpringKeyframe(100, duration: 0.3)
                        SpringKeyframe(-50, duration: 0.3)
                        SpringKeyframe(25, duration: 0.3)
                        SpringKeyframe(0, duration: 0.3)
                    }
                    // 2. waveHeight
                    // 我们希望高度从 0 改为 0.3 的位置
                    KeyframeTrack(\.waveHeight) {
                        CubicKeyframe(0.3, duration: 0.3)
                    }
                }
            )
            // 只有第一阶段才展示 View 1
            .opacity(animationPhase == .phase1 ? 1 : 0)
            // 老视图也 disabled 掉
            .animation(nil, value: animationPhase)
            // 第一阶段的动画完成了, 由于 keyframeAnimator 不能连续给 2 个, 我这边
            // 使用一个新的 View 盖住老的 View, 让第一阶段动画接受后, 新的 View 出现
            // 老的 View 消失
            // 新的 View
            LinearGradient(
                colors: [
                    Color.red.opacity(0.5),
                    Color.red.opacity(0.8)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            // 忽略安全区
            .ignoresSafeArea()
            .opacity(animationPhase == .phase2 ? 1 : 0)
            // 我们发现还有些小问题, animationPhase 改为 phase 2 的时候, 它会有动画
            .animation(nil, value: animationPhase)
            // 第二阶段的 View 充满全屏了 我们也要让他被裁减, 把同样的 keyframeAnimator 粘过来
            .keyframeAnimator(
                // 这里默认值就不能为 0 了, 我们希望它在第一阶段的基础上开始动画
                // 也就是第一阶段结束后的 Shape 形状
                initialValue: AnimationValues(
                    waveRange: 0,
                    waveHeight: 0.3
                ),
                trigger: triggerSecondAnimation,
                content: { content, value in
                    // 我们使用绘制好的 waveShape 裁剪红色渐变背景
                    content.mask {
                        WaveShape(
                            waveRange: value.waveRange,
                            waveHeight: value.waveHeight
                        )
                        // 忽略 mask 的安全区
                        .ignoresSafeArea()
                    }
                },
                keyframes: { _ in
                    // 做出充满全屏的动画效果
                    KeyframeTrack(\.waveRange) {
                        // wave 幅度直接变为凸起的效果
                        SpringKeyframe(100, duration: 0.3)
                        SpringKeyframe(200, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.waveHeight) {
                        CubicKeyframe(1, duration: 0.3)
                        // 防止盖不住全屏给一个 2 倍的 height
                        CubicKeyframe(2, duration: 0.3)
                    }
                }
            )
            
            // 文本信息也是在阶段1 之后才开始
            if animationPhase == .phase2 {
                VStack {
                    Text("YOU REALLY WENT THE DISTANCE")
                        .font(.title3)
                    Text("101 KM")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .transition(.opacity.combined(with: .slide))
                // 同时设置文本消失的动画
                .offset(y: triggerSecondAnimation ? -200 : 0)
                .opacity(triggerSecondAnimation ? 0 : 1)
                .animation(.smooth(duration: 0.6), value: triggerSecondAnimation)
            }
        }
        .onAppear {
            triggerFirstAnimation.toggle()
            Task {
                // 第一阶段需要 1.2s 的时间完成动画
                try await Task.sleep(for: .seconds(1.2))
                // 设置动画后, 展示我们的文本信息
                withAnimation {
                    animationPhase = .phase2
                }
            }
        }
        // 增加点击事件, 执行动画
        .onTapGesture {
            
            triggerSecondAnimation = true
        }
    }
}

#Preview {
    BackgroundColorAnimationView()
}

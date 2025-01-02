//
//  HorizontalPickerView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2025/1/2.
//

import SwiftUI

struct HorizontalPickerView: View {
    // 用来存储所有 Text 的 frame
    @State private var viewFrames: ViewFrames = .init()
    var contentViewSpacer = NamedCoordinateSpace.named("contentViewSpacer")
    // 3. 每次页面出现的时候自动滚到默认 age 的位置
    // 使用 iOS 18 的 API scroll position 来让视图自动滚到指定的 view id
    @State var scrollPosition = ScrollPosition(id: 20)
    @State var isScrolling = false
    
    var body: some View {
        // 我们先将实现拆分成 3 部, 依次完成它们
        // 1. 实现 ScrollView 中的内容滚动后, 接近最中间的元素自动到中间位置
        // 2. 将远离中间位置的元素缩小, 同时颜色变灰
        // 3. 每次页面出现的时候自动滚到默认 age 的位置
        ZStack {
            Color.darkBlue
                .ignoresSafeArea()
            // ScrollView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    // 随便给个区间 16 * 99 岁
                    ForEach(16..<99) { index in
                        Text("\(index)")
                            .font(.system(size: 50, weight: .medium))
                            // 改文本为白色
                            .foregroundStyle(.white)
                            .frame(width: 80, height: 80)
                            .background {
                                // 通过 preference 将所有 View 的 frame 拿到
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(
                                            key: ViewFrames.self,
                                            value: .init(frames: [index: proxy.frame(in: contentViewSpacer)])
                                        )
                                }
                            }
                            // 我们设置好 < 18 不允许选中, 并隐藏
                            .opacity(index < 18 ? 0 : 1)
                            // 2. 将远离中间位置的元素缩小, 同时颜色变灰
                            // 我们利用 iOS 17 的 API visualEffect 来实现, 缩放效果
                            // 这里我提前实现好了, 大家可以看一下
                            .visualEffect { view, proxy in
                                let frame = proxy.frame(in: .scrollView(axis: .horizontal))
                                // 获取 scrollView width
                                let parentBounds = proxy.bounds(of: .scrollView(axis: .horizontal)) ?? .zero
                                let scrollViewWidth = parentBounds.width
                                let distanceToOriginalX = min(
                                    max(0, frame.midX),
                                    scrollViewWidth
                                )
                                let centerX = scrollViewWidth / 2
                                let distanceToMidX = abs(distanceToOriginalX - centerX)
                                let normalizedDistance = distanceToMidX / centerX
                                // 获取 view 缩小的比例
                                let scaledValue = max(
                                    0.3,
                                    1 - normalizedDistance
                                )
                                // 原 App 中的效果会更丝滑一些, 他通过 offset 的偏移量动态计算了 view 消失的时机
                                // 我们这里就不花时间去 copy 了
                                // 毕竟想要做好一个组件, 需要投入大量的时间
                                // 我这里给大家提供思路, 可以发散一下
                                return view
                                    .scaleEffect(
                                        CGSize(width: scaledValue, height: scaledValue)
                                    )
                                    .brightness(scaledValue - 0.8)
                            }
                            .id(index)
                    }
                }
                // 设置好 NamedCoordinateSpace 才能让 37 行计算的 frame 是准确的
                // 效果是 ok 的了
                .coordinateSpace(contentViewSpacer)
                .onAppear {
                    // 默认滚动到 20 的位置
                    scrollPosition.scrollTo(id: 20, anchor: .center)
                }
            }
            // 设置外部圆角选中边框
            .overlay {
                // 我们还需要增加一个效果, 当用户停止滚动时, 边框出现
                // 滚动时边框消失
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white, lineWidth: 0.25)
                    .frame(width: 80, height: 80)
                    .opacity(isScrolling ? 0 : 1 )
                    .animation(.interactiveSpring, value: isScrolling)
            }
        }
        .onScrollPhaseChange { _, newPhase in
            isScrolling = newPhase.isScrolling
        }
        // 同时需要设置下 position
        .scrollPosition($scrollPosition, anchor: .center)
        // 这里获取所有子 View 的 frame 并存储起来
        .onPreferenceChange(ViewFrames.self) {
            viewFrames = $0
        }
        // 通过设置我们提前写好的 CenteringScrollTargetBehavior 来让 ScrollView 实现吸附中间元素的效果
        .scrollTargetBehavior(
            CenteringScrollTargetBehavior(viewFrames: viewFrames.frames) {
                print("Selected index: \($0)")
            }
        )
    }
}

// 我们先来实现第一步, ScrollView 自动吸附最中间的元素
// 这里我把代码粘过来, 原理是使用 iOS 17 的 ScrollTargetBehavior

struct ViewFrames: Equatable {
    var frames: [Int: CGRect] = [:]
}

extension ViewFrames: PreferenceKey {
    static var defaultValue: Self { .init() }
    
    static func reduce(
        value: inout ViewFrames,
        nextValue: () -> ViewFrames
    ) {
        value.frames.merge(nextValue().frames) { $1 }
    }
}

struct CenteringScrollTargetBehavior: ScrollTargetBehavior {
    let viewFrames: [Int: CGRect]
    var centerViewIndex: (Int) -> Void
    
    func updateTarget(
        _ target: inout ScrollTarget,
        context: TargetContext
    ) {
        let centerXProposed = target.rect.midX
        guard let nearestViewFrame = viewFrames.min(by: {
            ($0.value.midX - centerXProposed).magnitude < ($1.value.midX - centerXProposed).magnitude }
        ) else {
            return
        }
        centerViewIndex(nearestViewFrame.key)
        target.rect.origin.x = nearestViewFrame.value.midX - 0.5 * target.rect.size.width
    }
}

#Preview {
    HorizontalPickerView()
}

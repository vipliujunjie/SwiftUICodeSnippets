//
//  StickyHeaderView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/10.
//


import SwiftUI

struct StickyHeaderView: View {
    // 记录 scrollView 的偏移量
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Image("background")
                    .scaledToFill()
                    .frame(
                        // 由于向下拖拽 scrollView 时, offset 会变为负数
                        // e.g. -1, -2, -5, -10...
                        // 这里当判定 offset < 0 时将图片的 height 变大
                        // offset > 0, 图片高度不变
                        height: 400 + (scrollOffset < 0 ? -scrollOffset : 0)
                    )
                    .clipped()
                mockList()
            }
            .offset(y: scrollOffset > 0 ? 0 : scrollOffset)
        }
        .ignoresSafeArea()
        .onScrollGeometryChange(
            for: CGFloat.self,
            of: {
                $0.contentOffset.y
            },
            action: { oldValue, newValue in
                // 监听 scrollView 的 offsetY
                scrollOffset = newValue
            }
        )
    }
    
    private func mockList() -> some View {
        ForEach(0...100, id: \.self) { index in
            Text("\(index)")
                .padding()
        }
    }
}

#Preview {
    StickyHeaderView()
}

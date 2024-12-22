//
//  SubscribePage.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/20.
//

import SwiftUI

struct SubscribePage: View {
    var body: some View {
        ZStack {
            gradientBackground
                .ignoresSafeArea()
            //
            // 开始绘制内容
            VStack(alignment: .leading, spacing: 24) {
                // 同时增加一个 Spacer() 让主内容居中
                Spacer()
                // Title
                Text("Try Balabala\nMusic Premium")
                    .font(.largeTitle)
                    .fontDesign(.serif)
                Text("* $14.99/month")
                
                VStack(spacing: 16) {
                    HStack(spacing: 0) {
                        Text("Ad-free music in the Balabala Music app")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                    HStack(spacing: 0) {
                        Text("Background play")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                    HStack(spacing: 0) {
                        Text("Downloads")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                // 我们需要让按钮在底部展示
                Spacer()
                // 增加订阅按钮
                Button {
                    //
                } label: {
                    Text("Subscribe Now")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                VStack(spacing: 8) {
                    Text("Restrictions apply. Learn more here.")
                    Image(systemName: "chevron.down")
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 32)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            // 制造毛玻璃效果
            .background(.ultraThinMaterial)
            // 为了好看我们使用黑色主题
            .colorScheme(.dark)
        }
    }
    
    // 绘制渐变背景
    private var gradientBackground: some View {
        MeshGradient(
            width: 2,
            height: 3,
            points: [
                // 这里绘制一个 2x3 的网格
                // 左侧 3 个点, 右侧 3 个点
                [0.0, 0.0], [1.0, 0.0],
                [0.0, 0.5], [1.0, 0.5],
                [0.0, 1.0], [1.0, 1.0]
                // 补全 0 纯粹为了好看
            ],
            colors: [
                .blue, .green,
                .cyan, .black,
                .orange, .gray,
            ]
        )
    }
}

#Preview {
    SubscribePage()
}

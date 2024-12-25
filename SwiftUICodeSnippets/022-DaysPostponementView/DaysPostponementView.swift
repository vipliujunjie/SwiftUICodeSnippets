//
//  DaysPostponementView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/25.
//

import SwiftUI

// 创建一个 enum 用来维护所有的 days 选项
enum DaysOption: String, CaseIterable {
    case two = "2"
    case seven = "7"
    case fourteen = "14"
    case thirty = "30"
    case sixty = "60"
}

struct DaysPostponementView: View {
    // 维护当前选中的 days
    @State private var selectedDays: DaysOption = .fourteen
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 44) {
                // icon
                Image(systemName: "macbook.and.iphone")
                    .font(.title)
                    .foregroundStyle(.gray)
                    .padding(32)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
                VStack(spacing: 24) {
                    // title
                    Text("Rethink MackBook Pro in:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    // 添加 days 选择器
                    // 我们让文本对其
                    HStack(alignment: .firstTextBaseline) {
                        ForEach(DaysOption.allCases, id: \.self) { option in
                            let isSelected = selectedDays == option
                            VStack(spacing: 12) {
                                Text(option.rawValue)
                                    // 我们给选中的 days 增加一些样式
                                    .foregroundStyle(isSelected ? .pink : .gray)
                                    .font(isSelected ? .title : .title3)
                                    .fontWeight(isSelected ? .bold : .regular)
                                if isSelected {
                                    Text("DAYS")
                                        .font(.caption)
                                        .foregroundStyle(.pink.opacity(0.7))
                                }
                            }
                            // 制造圆角灰色背景效果
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background {
                                if isSelected {
                                    Color.gray.opacity(0.3)
                                        .cornerRadius(12)
                                }
                            }
                            // 目前每隔选项都各自有大小, 我们希望他们的 width 是一致的
                            // 这样中间的选项视图才能居中
                            .frame(maxWidth: .infinity)
                            // 增加点击事件
                            .onTapGesture {
                                // 增加一个系统的动画
                                withAnimation {
                                    selectedDays = option
                                }
                            }
                        }
                    }
                    // 给一些 padding 避免太宽
                    .padding(.horizontal, 32)
                    // description
                    Text("One of the basic ticks to avoid\nimpulsive purchase is to delay\nthem in time.")
                        .font(.title3)
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .offset(y: -60)
        }
        // 添加底部按钮
        .safeAreaInset(edge: .bottom) {
            Button {
                //
            } label: {
                // 这里需要根据选中的效果来展示 days
                Text("postpone for \(selectedDays.rawValue) days")
                    .font(.callout)
                    .foregroundStyle(.white)
                    // 制造胶囊背景效果
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.pink.opacity(0.6))
                    .clipShape(Capsule())
            }
            .padding()
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    DaysPostponementView()
}

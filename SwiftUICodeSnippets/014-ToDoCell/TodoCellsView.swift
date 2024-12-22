//
//  TodoCellsView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/15.
//

import SwiftUI

struct TodoCellsView: View {
    var body: some View {
        VStack(spacing: 0) {
            ToDoCell(emoji: "📚", title: "读书", isDone: true)
            Divider()
            ToDoCell(emoji: "⌨️", title: "写代码", isDone: false)
            Divider()
            ToDoCell(emoji: "🏊‍♀️", title: "游泳", isDone: false)
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
}

struct ToDoCell: View {
    let emoji: String
    let title: String
    @State var isDone: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text(emoji)
                .font(.title3)
            Text(title)
                .font(.title3)
                // 完成后文本变为删除效果, 同时颜色淡化
                .foregroundStyle(isDone ? .gray.opacity(0.7) : .primary)
                .strikethrough(isDone)
            Spacer()
            Image(systemName: isDone ? "checkmark.circle.fill" : "circle.fill")
                .imageScale(.large)
                // 给完成图标添加一些颜色和动画效果
                .foregroundStyle(isDone ? .yellow : .gray.opacity(0.3))
                .contentTransition(.symbolEffect(.replace))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        // 让点击区域变为整个 Cell, 不添加这行代码 Spacer() 填充的
        // 位置无法被点击
        .contentShape(Rectangle())
        .onTapGesture {
            // 点击 Cell 后触发完成操作
            withAnimation(.easeInOut) {
                isDone.toggle()
            }
        }
    }
}

#Preview {
    TodoCellsView()
}

//
//  ContentView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//


import SwiftUI
import TipKit

struct PopoverTip: Tip {
    var title: Text {
        Text("查看详情")
            .foregroundStyle(.indigo)
    }
    
    var message: Text? {
        Text("点击 \(Image(systemName: "globe")) 查看更多信息")
    }
}

struct PopoverTipView: View {
    var body: some View {
        Text("Hello, world")
            .popoverTip(PopoverTip())
            .task {
                try? Tips.configure()
            }
    }
}

#Preview {
    PopoverTipView()
}

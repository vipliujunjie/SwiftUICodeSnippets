//
//  SnowShaderView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/24.
//

import SwiftUI

struct SnowShaderView: View {
    let start = Date.now
    
    var body: some View {
        ZStack {
            // 这里才是我们的颜色
            Color.black
                .ignoresSafeArea()
            // 这个颜色板块会被 shader 重新渲染后的雪的颜色重写调, 我们其实不太关心
            // 它具体是什么颜色, 给一个站位的 View 即可
            TimelineView(.animation) { context in
                let time = start.distance(to: context.date)
                Rectangle()
                    .ignoresSafeArea()
                // 我们去创建一个 Shader 文件
                    .visualEffect { view, proxy in
                        view.colorEffect(
                            ShaderLibrary.snow(
                                // 参数弄反了, 第一个是 time
                                // 发现有底色我们去调整下
                                // 现在我们让雪花飘起来
                                .float(time),
                                // 方向好像有点反了, 我们将 speed 改成了负数
                                .float2(proxy.size.width, proxy.size.height)
                            )
                        )
                    }
            }
            Text("🎄 Merry Christmas 🎄")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SnowShaderView()
}

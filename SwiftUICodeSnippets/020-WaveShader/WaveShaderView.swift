//
//  WaveShaderView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/24.
//

import SwiftUI

struct WaveShaderView: View {
    var body: some View {
        let start = Date.now
        TimelineView(.animation) { context in
            // .animation 会根据系统给出一个合理的回掉次数
            // 这里通过回掉时的 date 减去 start 来计算出一个时间戳
            // e.g. 0.3, 0.4, 0.6, 1 xxx 之类的 (具体取决于系统 1s 内回掉次数)
            let time = start.distance(to: context.date)
            Image("image-6")
                .resizable()
                .scaledToFit()
                .padding(24)
                .distortionEffect(
                    // 如果 time 是 1, 图片会出现固定的波纹效果
                    ShaderLibrary.wave(.float(time)),
                    maxSampleOffset: .zero
                )
        }
    }
}

#Preview {
    WaveShaderView()
}

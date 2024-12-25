//
//  CenteringScrollTargetBehaviorView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/25.
//

import SwiftUI

struct CenteringScrollTargetBehaviorView: View {
    @State private var viewFrames: ViewFrames = .init()
    private let scrollViewSpacer = NamedCoordinateSpace.named("ScrollView")
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(0..<20) { index in
                    Text("\(index)")
                        .font(.title)
                        .frame(width: 50, height: 80)
                        .cornerRadius(12)
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(
                                        key: ViewFrames.self,
                                        value: .init(frames: [index: proxy.frame(in: scrollViewSpacer)])
                                    )
                            }
                        }
                        .visualEffect { view, proxy in
                            view
                        }
                }
            }
            .coordinateSpace(scrollViewSpacer)
            .scrollTargetLayout()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.red.opacity(0.3))
                .frame(width: 50, height: 80)
        }
        .onPreferenceChange(ViewFrames.self) {
            viewFrames = $0
        }
        .scrollTargetBehavior(CenteringScrollTargetBehavior(viewFrames: viewFrames.frames))
    }
}

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
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let centerXProposed = target.rect.midX
        print("\(viewFrames)\n\(centerXProposed)\n\(target)")
        guard let nearestViewFrame = viewFrames.min(by: {
            ($0.value.midX - centerXProposed).magnitude < ($1.value.midX - centerXProposed).magnitude }
        ) else {
            return
        }
        print("=== \(nearestViewFrame.value.midX - 0.5 * target.rect.size.width)")
        target.rect.origin.x = nearestViewFrame.value.midX - 0.5 * target.rect.size.width
    }
}

#Preview {
    CenteringScrollTargetBehaviorView()
}

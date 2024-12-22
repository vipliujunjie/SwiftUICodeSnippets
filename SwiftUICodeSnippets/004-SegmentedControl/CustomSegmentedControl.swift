//
//  CustomSegmentedControl.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Namespace var nameSpace
    @State private var currentTab: Tab = .first
    
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation {
                            currentTab = tab
                        }
                    } label: {
                        Text(tab.rawValue)
                            .foregroundStyle(.black)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background {
                                if currentTab == tab {
                                    Capsule()
                                        .fill(.white)
                                        .matchedGeometryEffect(
                                            id: "Tab",
                                            in: nameSpace
                                        )
                                }
                            }
                    }
                }
            }
            .frame(width: 200)
            .padding(2)
            .background {
                Capsule()
                    .fill(.gray.opacity(0.5))
            }
        }
    }
}

enum Tab: String, CaseIterable {
    case first = "First"
    case second = "Second"
}

#Preview {
    CustomSegmentedControl()
}

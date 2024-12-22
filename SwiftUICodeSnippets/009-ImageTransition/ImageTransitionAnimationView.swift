//
//  ImageTransitionAnimationView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/9.
//

import SwiftUI

struct ImageTransitionAnimationView: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        ZStack {
            if toggle {
                Image("car-image-1")
                    .resizable()
                    .transition(.blurReplace)
            } else {
                Image("car-image-2")
                    .resizable()
                    .transition(.blurReplace)
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: 300)
        .cornerRadius(24)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 2)) {
                toggle.toggle()
            }
        }
    }
}

#Preview {
    ImageTransitionAnimationView()
}

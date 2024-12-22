//
//  SymbolImageAnimation.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//

import SwiftUI

struct SymbolImageAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                isAnimating.toggle()
            } label: {
                Image(systemName: "arrowshape.up")
                    .imageScale(.large)
                    .symbolEffect(.bounce, value: isAnimating)
            }
            Button {
                isAnimating.toggle()
            } label: {
                Image(systemName: "arrowshape.up")
                    .imageScale(.large)
                    .symbolEffect(.pulse, value: isAnimating)
            }
            Button {
                isAnimating.toggle()
            } label: {
                Image(systemName: "arrowshape.up")
                    .imageScale(.large)
                    .symbolEffect(.rotate, value: isAnimating)
            }
            Button {
                isAnimating.toggle()
            } label: {
                Image(systemName: "arrowshape.up")
                    .imageScale(.large)
                    .symbolEffect(.wiggle, value: isAnimating)
            }
        }
        .accentColor(.black)
    }
}

#Preview {
    SymbolImageAnimation()
}

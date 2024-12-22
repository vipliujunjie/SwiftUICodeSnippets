//
//  ButtonRotateAnimation.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/21.
//

import SwiftUI

struct ButtonRotateAnimation: View {
    @State private var isRotated = false
    
    var body: some View {
        Button {
            isRotated.toggle()
        } label: {
            Image(systemName: "chevron.right.circle")
                .font(.largeTitle)
                .rotationEffect(.degrees(isRotated ? 90 : 0))
                .animation(.default, value: isRotated)
        }
    }
}

#Preview {
    ButtonRotateAnimation()
}

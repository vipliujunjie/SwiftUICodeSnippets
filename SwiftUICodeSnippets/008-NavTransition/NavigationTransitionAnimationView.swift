//
//  NavigationTransitionAnimationView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/9.
//

import SwiftUI

struct NavigationTransitionAnimationView: View {
    @Namespace private var scrollView
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(0...100, id: \.self) { index in
                        NavigationLink {
                            largeLabel(title: "\(index)")
                                .navigationBarBackButtonHidden()
                                .navigationTransition(.zoom(sourceID: index, in: scrollView))
                        } label: {
                            largeLabel(title: "\(index)")
                                .frame(height: 100)
                                .cornerRadius(24)
                        }
                        .matchedTransitionSource(
                            id: index,
                            in: scrollView
                        )
                    }
                }
                .padding()
            }
        }
    }
    
    func largeLabel(title: String) -> some View {
        Text(title)
            .font(.title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
    }
}

#Preview {
    NavigationTransitionAnimationView()
}

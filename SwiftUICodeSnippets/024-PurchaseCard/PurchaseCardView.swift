//
//  PurchaseCardView.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/27.
//

import SwiftUI

// 做一个 Product 的 Model
struct Product {
    var title: String
    var description: String
    var price: String
    
    // 同时制造几个 Mock 数据
    static var swiftProduct: Product {
        .init(
            title: "Swift 教程",
            description: "一次性买断, 永久可访问",
            price: "$99"
        )
    }
    
    static var swiftUIProduct: Product {
        .init(
            title: "SwiftUI 教程",
            description: "一次性买断, 永久可访问",
            price: "$99"
        )
    }
    
    static var iOSProduct: Product {
        .init(
            title: "iOS 教程",
            description: "一次性买断, 永久可访问",
            price: "$99"
        )
    }
}

struct PurchaseCardView: View {
    // 制造选中效果
    @State private var selectedProduct: Product?
    // 当前 Hover 的 Product
    @State private var hoveredProduct: Product?
    
    var allProducts: [Product] = [
        .swiftProduct, .swiftUIProduct, .iOSProduct
    ]
    
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            // spacing 改大点
            HStack(spacing: 24) {
                // 先只展示一个卡片 iPhone 的 preview 有些小
                // 由于 preview 不能展示 hover 效果, 我们改为 mac app 展示
                ForEach(allProducts, id: \.title) { product in
                    cardView(product: product)
                }
            }
        }
        // 我们制造一个黑色主题的效果
        .colorScheme(.dark)
    }
    
    // 卡片视图
    @ViewBuilder
    func cardView(product: Product) -> some View {
        // 制造选中的效果
        let isSelected = product.title == selectedProduct?.title
        let isHovered = product.title == hoveredProduct?.title
        VStack(alignment: .leading, spacing: 12) {
            // 调整下 UI
            Text(product.title)
                .frame(height: 30)
            Text(product.price)
                .font(.title)
                .fontWeight(.bold)
            Text(product.description)
                .font(.footnote)
                .foregroundStyle(.secondary)
            // 支付按钮, 我们只需要在选中/Hover 的时候展示`购买按钮`
            Button {
                //
            } label: {
                Text("购买")
                    .foregroundStyle(.black)
                    .font(.callout)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(Color.primary)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .opacity(isHovered || isSelected ? 1 : 0)
        }
        .frame(width: 100)
        // 制造卡片效果
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color.indigo : Color.black.opacity(0.3))
                .stroke(
                    // Hover 时候改为紫色
                    isHovered ? Color.indigo : Color.white,
                    lineWidth: 2
                )
        }
        .onTapGesture {
            selectedProduct = product
        }
        // 监听 hover 状态
        .onHover { isHovered in
            hoveredProduct = isHovered ? product : nil
        }
    }
}

#Preview {
    PurchaseCardView()
}

//
//  LoginPage.swift
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/18.
//

import SwiftUI

struct LoginPage: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            // 紫色背景
            Color.indigo
                .ignoresSafeArea()
            
            // 我们只做一个卡片效果
            VStack(alignment: .leading, spacing: 16) {
                // 左上角的 Logo
                HStack {
                    Image(systemName: "sparkle")
                        .font(.title)
                        .padding(10)
                        .background(Circle().fill(Color.gray.opacity(0.08)))
                    Spacer()
                }
                // 一些介绍文本
                Text("Get Started")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Register for events, subscribe to calendars and manage events you're going to.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                // 登陆按钮
                // 按钮之间的间距有些大, 我们调整小一点
                VStack(spacing: 10) {
                    // Phone
                    Button {
                        //
                    } label: {
                        Text("Continue with Phone")
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            // 制造一个卡片效果
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .cornerRadius(12)
                    }
                    // Email
                    Button {
                        //
                    } label: {
                        Text("Continue With Email")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            // 制造一个卡片效果
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                    }
                    HStack(spacing: 10) {
                        // Apple
                        Button {
                            //
                        } label: {
                            Image(systemName: "apple.logo")
                                .imageScale(.large)
                                .frame(maxWidth: .infinity)
                                // 制造一个卡片效果
                                .padding(.vertical, 12)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        // Google
                        Button {
                            //
                        } label: {
                            Image(systemName: "g.square")
                                .imageScale(.large)
                                .frame(maxWidth: .infinity)
                                // 制造一个卡片效果
                                .padding(.vertical, 12)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                    }
                }
            }
            .padding(20)
            // 底部额外增加 24 间距
            .padding(.bottom, 24)
            .background(Color.white)
            .cornerRadius(32)
            .padding(12)
            // 将按钮的图标和文本改为黑色
            .tint(Color.black)
        }
    }
}

#Preview {
    LoginPage()
}

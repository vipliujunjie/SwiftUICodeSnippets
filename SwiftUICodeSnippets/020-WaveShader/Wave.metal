//
//  Wave.metal
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/24.
//

#include <metal_stdlib>
using namespace metal;

// 这里粘贴过来的方法是 SwiftUI 桥接 Shader 方法的固定写法
// 我们可以更改方法名称, 以及后面的额外参数
// 这里我添加了一个参数 time 用来做动态效果
[[ stitchable ]] float2 wave(float2 position, float time) {
    // position 为每隔像素点的位置
    // 我们将 y 得值动态增加 -1 ~ 1 (sin 之后的值)
    // 增加一些 y 的偏移幅度, 同时减少相邻 y 之间的差异 (position.y / 20, 之后会让 sin 0~1 的周期变长)
    position.y += 3 * sin(time + position.y / 20);
    return position;
}

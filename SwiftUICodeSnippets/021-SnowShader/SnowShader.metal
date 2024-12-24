//
//  SnowShader.metal
//  SwiftUICodeSnippets
//
//  Created by Mason Sun on 2024/12/24.
//

#include <metal_stdlib>
using namespace metal;

// 我们去网上找一个下雪的 shader 效果, 不过这不是 SwiftUI 里可以直接使用的
// 我们需要让别人帮我们转化下, 打开我们的好兄弟 cursor

[[ stitchable ]] half4 snow(float2 position,
                            // 好兄弟转换的有点问题, 这个 bounds 没有用, 但 SwiftUI 中需要有一个 color 的参数, 我们帮好兄弟改一下 😂
                            // 看下效果
                           half4 color,
                           float time,
                           float2 resolution) {
    float snow = 0.0;
    float gradient = (1.0-float(position.y / resolution.x))*0.4;
    float random = fract(sin(dot(position.xy,float2(12.9898,78.233)))* 43758.5453);
    
    for(int k=0;k<6;k++){
        for(int i=0;i<8;i++){
            float cellSize = 1 + (float(i)*3.0);
            float downSpeed = -0.3+(sin(time*0.4+float(k+i*20))+1.0)*0.00008;
            float2 uv = (position.xy / resolution.x)+float2(0.01*sin((time+float(k*6185))*0.6+float(i))*(5.0/float(i)),downSpeed*(time+float(k*1352))*(1.0/float(i)));
            float2 uvStep = (ceil((uv)*cellSize-float2(0.5,0.5))/cellSize);
            float x = fract(sin(dot(uvStep.xy,float2(12.9898+float(k)*12.0,78.233+float(k)*315.156)))* 43758.5453+float(k)*12.0)-0.5;
            float y = fract(sin(dot(uvStep.xy,float2(62.2364+float(k)*23.0,94.674+float(k)*95.0)))* 62159.8432+float(k)*12.0)-0.5;

            float randomMagnitude1 = sin(time*2.5)*0.7/cellSize;
            float randomMagnitude2 = cos(time*2.5)*0.7/cellSize;

            float d = 5.0*distance((uvStep.xy + float2(x*sin(y),y)*randomMagnitude1 + float2(y,x)*randomMagnitude2),uv.xy);

            float omiVal = fract(sin(dot(uvStep.xy,float2(32.4691,94.615)))* 31572.1684);
            if(omiVal<0.08){
                float newd = (x+1.0)*0.4*clamp(1.9-d*(15.0+(x*6.3))*(cellSize/1.4),0.0,1.0);
                snow += newd;
            }
        }
    }
    // 这里把 gradient 直接干掉
    return half4(snow) + random*0.01;
}

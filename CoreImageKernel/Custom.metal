//
//  Custom.metal
//
//  Created by Mert Tuzer on 25.04.2020.
//  Copyright © 2020 Mert Tuzer. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include <CoreImage/CoreImage.h> // (1)

float3 multiplyColor(float3, float3);
float3 multiplyColor(float3 mainColor, float3 colorMultiplier) { // (2)
    float3 color = float3(0,0,0);
    color.r = mainColor.r * colorMultiplier.r;
    color.g = mainColor.g * colorMultiplier.g;
    color.b = mainColor.b * colorMultiplier.b;
    return color;
};

extern "C" { namespace coreimage {               // (3)
    float4 dyeInThree(sampler src, float3 redVector, float3 greenVector, float3 blueVector) {

        float2 pos = src.coord();
        float4 pixelColor = src.sample(pos);     // (4)
        
        float3 pixelRGB = pixelColor.rgb;
        
        float3 color = float3(0,0,0);
        if (pos.y < 0.33) {                      // (5)
            color = multiplyColor(pixelRGB, redVector);
        } else if (pos.y >= 0.33 && pos.y < 0.66) {
            color = multiplyColor(pixelRGB, greenVector);
        } else {
            color = multiplyColor(pixelRGB, blueVector);
        }

        return float4(color, 1.0);
    }
}}

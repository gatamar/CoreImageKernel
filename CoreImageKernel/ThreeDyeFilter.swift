//  ThreeDyeFilter.swift
//
//  Created by Mert Tuzer on 25.04.2020.
//  Copyright © 2020 Mert Tuzer. All rights reserved.

import CoreImage

class ThreeDyeFilter: CIFilter {
    private let kernel: CIKernel
    var inputImage: CIImage? // (1)
    
    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "dyeInThree", fromMetalLibraryData: data) // (2)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var outputImage: CIImage? {
        guard let inputImage = self.inputImage else { return nil }
        let inputExtent = inputImage.extent
        
        let reddish   = CIVector(x: 1.1, y: 0.1, z: 0.1) // (3)
        let greenish  = CIVector(x: 0.1, y: 1.1, z: 0.1)
        let blueish   = CIVector(x: 0.1, y: 0.1, z: 1.1)

        let roiCallback: CIKernelROICallback = { _, rect -> CGRect in  // (4)
            return rect
        }

        return self.kernel.apply(extent: inputExtent,
                                 roiCallback: roiCallback,
                                 arguments: [inputImage, reddish, greenish, blueish])  // (5)
    }
}

//
//  ViewController.swift
//  CoreImageKernel
//
//  Created by Olha Pavliuk on 22.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filter = ThreeDyeFilter()
        let inputImageURL = Bundle.main.url(forResource: "input_image", withExtension: "png")!
        let imageToBeProcessed = CIImage(contentsOf: inputImageURL)
        filter.inputImage = imageToBeProcessed // a CIImage
        
        let imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)
        imageView.image = UIImage(ciImage: filter.outputImage!)
    }


}


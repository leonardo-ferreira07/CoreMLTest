//
//  ViewModel.swift
//  CoreMLTest
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 15/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewModel: NSObject {
    
    lazy var inception: Inceptionv3 = Inceptionv3()
    
    func classify(image: UIImage) {
        
        guard let visionCoreMLModel = try? VNCoreMLModel(for: inception.model) else {
            fatalError("Unable to convert to Vision Core ML Model")
        }
        
        let classificationRequest = VNCoreMLRequest(model: visionCoreMLModel, completionHandler: self.handleClassificationResults)
        
        guard let cgImage = image.cgImage else {
            fatalError("Unable to convert \(image) to CGImage.")
        }
        let cgImageOrientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: cgImageOrientation)
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([classificationRequest])
            } catch {
                print("Error performing food classification")
            }
        }
    }
    
    private func handleClassificationResults(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let classifications = request.results as? [VNClassificationObservation], let topClassification = classifications.first else {
                    return
            }
            
            print(topClassification.identifier)
        }
    }
    
}

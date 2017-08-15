//
//  ViewModel.swift
//  CoreMLTest
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 15/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit
import CoreML

class ViewModel: NSObject {
    
    lazy var inception: Inceptionv3 = Inceptionv3()
    
    func classify(image: UIImage) -> String {
        let buffer = CoreMLHelper.pixelBufferFromImage(image: image)
        do {
            let answer = try inception.prediction(image: buffer)
            return answer.classLabel
        } catch {
            print(error)
        }
        return "ops, not a match"
    }
    
}

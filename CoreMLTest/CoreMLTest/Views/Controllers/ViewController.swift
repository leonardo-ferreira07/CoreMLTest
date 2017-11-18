//
//  ViewController.swift
//  CoreMLTest
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 15/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func pickSomeImagePressed(_ sender: UIButton) {
        buildAndPresentPicker()
    }
    

}

// MARK: - Picker actions

extension ViewController {
    
    func buildAndPresentPicker() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take a picture", style: .default) { (_) in
            self.takePicture()
        }
        let libraryAction = UIAlertAction(title: "Choose from library", style: .default) { (_) in
            self.choosePicture()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func choosePicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takePicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - Picker Delegate

extension ViewController {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            print(viewModel.classify(image: image))
        }
    }
    
}

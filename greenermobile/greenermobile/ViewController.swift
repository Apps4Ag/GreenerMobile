//
//  ViewController.swift
//  greenermobile
//
//  Created by Scott Kirkland on 7/29/17.
//  Copyright © 2017 Scott Kirkland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static var plantImage: UIImage!
    
    var imagePicker: UIImagePickerController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // padding 16
        let myImages = ["insta_photo","insta_photo","insta_photo","insta_photo"]
        let imageWidth:CGFloat = 118
        let imageHeight:CGFloat = 157
        var xPosition:CGFloat = 0
        var scrollViewSize:CGFloat=0
        
        for image in myImages {
            let myImage:UIImage = UIImage(named: image)!

            let btn = UIButton()
            btn.setImage(myImage, for: .normal)

            btn.frame.size.width = imageWidth
            btn.frame.size.height = imageHeight
            btn.frame.origin.x = xPosition + 16
            btn.frame.origin.y = 10
            
            scrollSolutions.addSubview(btn)
            xPosition += imageWidth + 16
            scrollViewSize += imageWidth
        }
        scrollSolutions.contentSize = CGSize(width: scrollViewSize, height: imageHeight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        ViewController.plantImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.performSegue(withIdentifier: "segueProgress", sender: self)
    }

    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
//            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
        } else {
            // for now, if you don't have camera access then use image picker
            imagePicker = UIImagePickerController()
                
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
                
            self.present(imagePicker, animated: true,
                            completion: nil)
        }
    }

    @IBOutlet weak var scrollSolutions: UIScrollView!
}


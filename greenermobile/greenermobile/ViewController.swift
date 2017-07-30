//
//  ViewController.swift
//  greenermobile
//
//  Created by Scott Kirkland on 7/29/17.
//  Copyright © 2017 Scott Kirkland. All rights reserved.
//

import UIKit

class ResultDetail {
    init() {}

    init(diagnosis: String, plantName: String, latinName: String) {
        self.diagnosis = diagnosis
        self.plantName = plantName
        self.latinName = latinName
        ViewController.plantImage = UIImage(named: "strawberry")
    }

    var diagnosis: String = "Root Rot"
    var plantName: String = "Tomato"
    var latinName: String = "Tomatus Plantus"
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static var plantImage: UIImage!
    static var plantResult: ResultDetail = ResultDetail()
    
    let myImages = ["acp","strawberry","insta_photo","insta_photo"]
    
    var imagePicker: UIImagePickerController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "greener_logo"))
        
        let padding = CGFloat(16)
        let imageWidth:CGFloat = 118
        let imageHeight:CGFloat = 157
        var xPosition:CGFloat = 0
        var scrollViewSize:CGFloat=0

        var index = 0
        for image in self.myImages {
            let myImage:UIImage = UIImage(named: image)!

            let btn = UIButton()
            btn.tag = index
            btn.setImage(myImage, for: .normal)
            btn.imageView?.contentMode = .scaleAspectFill
            btn.frame.size.width = imageWidth
            btn.frame.size.height = imageHeight
            btn.frame.origin.x = xPosition + padding
            btn.frame.origin.y = 10

            btn.addTarget(self, action: #selector(imageTap), for: .touchUpInside)

            scrollSolutions.addSubview(btn)
            xPosition += imageWidth + padding
            scrollViewSize += imageWidth
            
            index = index + 1
        }
        scrollSolutions.contentSize = CGSize(width: scrollViewSize, height: imageHeight)
        
    }
    
    func imageTap(sender: UIButton) {
        print(sender.tag)
        print(self.myImages[sender.tag])
        
        switch sender.tag {
        case 0:
            ViewController.plantResult = ResultDetail(diagnosis: "Asian Citrus Psyllid", plantName: "Citrus", latinName: "Citreae")
            ViewController.plantImage = UIImage(named: "acp")
        case 1:
            ViewController.plantResult = ResultDetail(diagnosis: "Botrytis Fruit Rot", plantName: "Strawberry", latinName: "Fragaria × ananassa")
            ViewController.plantImage = UIImage(named: "strawberry")
        case 2:
            ViewController.plantResult = ResultDetail(diagnosis: "Rot something", plantName: "Strawberry", latinName: "Stawbericus Maximus")
        case 3:
            ViewController.plantResult = ResultDetail(diagnosis: "Rot something", plantName: "Strawberry", latinName: "Stawbericus Maximus")
        default:
            ViewController.plantResult = ResultDetail()
        }
    
        self.performSegue(withIdentifier: "segueResults", sender: self)
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


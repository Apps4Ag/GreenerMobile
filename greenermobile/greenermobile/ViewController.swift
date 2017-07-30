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

    init(diagnosis: String, plantName: String, latinName: String, description: String) {
        self.diagnosis = diagnosis
        self.plantName = plantName
        self.latinName = latinName
        self.description = description
    }

    var diagnosis: String = "Root Rot"
    var plantName: String = "Tomato"
    var latinName: String = "Tomatus Plantus"
    var description: String = "Lorem ipsum"
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static var plantImage: UIImage!
    static var plantResult: ResultDetail = ResultDetail()
    
    let myImages = ["acp","strawberry","powderymildew","strawberry"]
    
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
            ViewController.plantResult = ResultDetail(diagnosis: "Asian Citrus Psyllid", plantName: "Citrus", latinName: "Citreae", description: "The Asian citrus psyllid, Diaphorina citri (or ACP), is a tiny, mottled brown insect about the size of an aphid that poses a serious threat to California's citrus trees—including those grown in home gardens and on farms. The psyllid feeds on all varieties of citrus (e.g., oranges, grapefruit, lemons, and mandarins) and several closely related ornamental plants in the family Rutaceae (e.g., calamondin, box orange, Indian curry leaf, and orange jessamine or orange jasmine).")
            ViewController.plantImage = UIImage(named: "acp")
        case 1:
            ViewController.plantResult = ResultDetail(diagnosis: "Botrytis Fruit Rot", plantName: "Strawberry", latinName: "Fragaria × ananassa", description: "The fungus that causes Botrytis fruit rot, also known as gray mold, is widespread in the environment. It can infect strawberry flowers when spores landing on them are exposed to free water and cool temperatures. Infections can either cause flowers to rot or Botrytis can become dormant in floral tissues. Dormant infections resume activity on the berry later in the season anytime before or after harvest when sugars increase and conditions become favorable to disease development")
            ViewController.plantImage = UIImage(named: "strawberry")
        case 2:
            ViewController.plantResult = ResultDetail(diagnosis: "Powdery Mildew", plantName: "Strawberry", latinName: "Fragaria × ananassa", description: "Leaves infected with powdery mildew initially have small, white powdery colonies on the undersides of leaves. These colonies enlarge to cover the entire lower leaf surface, causing the edges of the leaves to roll up. Purple reddish blotches appear on the upper and lower surface of leaves. Infected flowers produce deformed fruit or no fruit at all. Severely infected flowers may be completely covered by mycelium and killed. Infected immature fruits become hardened and desiccated. Infected mature fruits become seedy in appearance and support spore-producing colonies that look powdery and white.")
        case 3:
            ViewController.plantResult = ResultDetail(diagnosis: "Rot something", plantName: "Strawberry", latinName: "Stawbericus Maximus", description: "Leaves infected with powdery mildew initially have small, white powdery colonies on the undersides of leaves. These colonies enlarge to cover the entire lower leaf surface, causing the edges of the leaves to roll up. Purple reddish blotches appear on the upper and lower surface of leaves. Infected flowers produce deformed fruit or no fruit at all. Severely infected flowers may be completely covered by mycelium and killed. Infected immature fruits become hardened and desiccated. Infected mature fruits become seedy in appearance and support spore-producing colonies that look powdery and white.")
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


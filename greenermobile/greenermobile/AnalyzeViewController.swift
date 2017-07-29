//
//  ViewController.swift
//  greenermobile
//
//  Created by Scott Kirkland on 7/29/17.
//  Copyright © 2017 Scott Kirkland. All rights reserved.
//

import UIKit
import Alamofire

class AnalyzeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded analyze")
        
        if (ViewController.plantImage != nil) {
            print(ViewController.plantImage.description)
            
//            let imageurl = "https://storage.googleapis.com/appsforag/gardenia_bad/DSC_0001.JPG"
            let apiUrl = URL(string: "https://tranquil-hollows-94349.herokuapp.com/api/image")
            
            let imageData = UIImageJPEGRepresentation(ViewController.plantImage, 1.0)!
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "file")
                    multipartFormData.append("upload.JPG".data(using: .utf8)!, withName: "filename")
                },
                usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                to: apiUrl!,
                method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            debugPrint(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
            // Use Alamofire to upload the image
//            Alamofire.upload(imageData, to: urlString!).responseJSON { response in
//                debugPrint(response)
//            }
        // Do any additional setup after loading the view, typically from a nib.
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


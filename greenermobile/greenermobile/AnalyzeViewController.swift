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
//            let apiUrl = URL(string: "https://tranquil-hollows-94349.herokuapp.com/api/image")
            let apiUrl = URL(string: "https://tranquil--hollows--94349-herokuapp-com-c9u13my920ue.runscope.net/api/image")
            
            let imageData = resizeImage(image: ViewController.plantImage)
            //let imageData = UIImageJPEGRepresentation(ViewController.plantImage, 0.25)!
            
//            let headers: HTTPHeaders = [
//                "Content-Type": "",
//            ]
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "file")
                    multipartFormData.append("upload.JPG".data(using: .utf8)!, withName: "filename")
                },
                usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                to: apiUrl!,
                method: .post,
//                headers: headers,
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
    
    func resizeImage(image: UIImage) -> Data
    {
 
    var actualHeight = image.size.height;
    var actualWidth = image.size.width;
    let maxHeight = CGFloat(400.0);
    let maxWidth = CGFloat(300.0);
    var imgRatio = actualWidth/actualHeight;
    let maxRatio = maxWidth/maxHeight;
    let compressionQuality = CGFloat(0.5);//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
    if(imgRatio < maxRatio)
    {
    //adjust width according to maxHeight
    imgRatio = maxHeight / actualHeight;
    actualWidth = imgRatio * actualWidth;
    actualHeight = maxHeight;
    }
    else if(imgRatio > maxRatio)
    {
    //adjust height according to maxWidth
    imgRatio = maxWidth / actualWidth;
    actualHeight = imgRatio * actualHeight;
    actualWidth = maxWidth;
    }
    else
    {
    actualHeight = maxHeight;
    actualWidth = maxWidth;
    }
    }
    
    let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
    UIGraphicsBeginImageContext(rect.size);
    image.draw(in: rect)

    let img = UIGraphicsGetImageFromCurrentImageContext();
    let imageData = UIImageJPEGRepresentation(img!, compressionQuality)
        
    UIGraphicsEndImageContext();

        return imageData!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


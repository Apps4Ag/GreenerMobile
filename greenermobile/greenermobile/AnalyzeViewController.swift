//
//  ViewController.swift
//  greenermobile
//
//  Created by Scott Kirkland on 7/29/17.
//  Copyright © 2017 Scott Kirkland. All rights reserved.
//

import UIKit

class AnalyzeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded analyze")
        
        if (ViewController.plantImage != nil) {
            print(ViewController.plantImage.description)
            
            let urlString = URL(string: "https://tranquil-hollows-94349.herokuapp.com/api/image")
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: urlString!)
            request.httpMethod = "POST"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("*****error")
                    return
                }
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("*****This is the data: \(dataString)") //JSONSerialization
            }
            
            task.resume()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(NSString("test"))
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
}


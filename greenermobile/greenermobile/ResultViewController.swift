//
//  ResultViewController.swift
//  greenermobile
//
//  Created by Scott Kirkland on 7/29/17.
//  Copyright © 2017 Scott Kirkland. All rights reserved.
//

import UIKit
import Alamofire

class ResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = ViewController.plantResult
        
        lblDiagnosis.text = result.diagnosis
        lblPlantName.text = result.plantName
        lblLatinName.text = result.latinName
    }
    @IBOutlet weak var imgResultPhoto: UIImageView!
    
    @IBOutlet weak var lblDiagnosis: UILabel!
    
    @IBOutlet weak var lblPlantName: UILabel!
    
    @IBOutlet weak var lblLatinName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateTaken: UILabel!
}

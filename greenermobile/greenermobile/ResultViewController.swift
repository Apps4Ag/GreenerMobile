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
        
        // remove loading screen from hierarchy if
        let loadingScreen = self.navigationController?.viewControllers[1]

        if ((loadingScreen != nil) && loadingScreen is AnalyzeViewController) {
            self.navigationController?.viewControllers.remove(at: 1)
        }

        let result = ViewController.plantResult
        
        lblDiagnosis.text = result.diagnosis
        lblPlantName.text = result.plantName
        lblLatinName.text = result.latinName
        lblDate.text = "29 July 2017"
        lblDateTaken.text = "Date Taken"
        
        if (lblDiagnosis.text == "gardenia bad") {
            lblDiagnosis.text = "Mineral Deficiency"
        } else if (lblDiagnosis.text == "gardenia good") {
            lblDiagnosis.text = "No Issues Detected"
        }
    }

    @IBOutlet weak var imgResultPhoto: UIImageView!
    
    @IBOutlet weak var lblDiagnosis: UILabel!
    
    @IBOutlet weak var lblPlantName: UILabel!
    
    @IBOutlet weak var lblLatinName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateTaken: UILabel!
}

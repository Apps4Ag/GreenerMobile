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
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "greener_logo"))

        // remove loading screen from hierarchy if
        let loadingScreen = self.navigationController?.viewControllers[1]

        if ((loadingScreen != nil) && loadingScreen is AnalyzeViewController) {
            self.navigationController?.viewControllers.remove(at: 1)
        }
        
        if (ViewController.plantImage != nil) {
            imgResultPhoto.image = ViewController.plantImage
        }

        let result = ViewController.plantResult
        
        lblDiagnosis.text = result.diagnosis
        lblPlantName.text = result.plantName
        lblLatinName.text = result.latinName
        lblDate.text = "30 July 2017"
        lblDateTaken.text = "Date Taken"
        txtDescription.text = result.description
        
        if (lblDiagnosis.text == "gardenia bad") {
            lblDiagnosis.text = "Mineral Deficiency"
            lblPlantName.text = "Gardenia"
            lblLatinName.text = "Gardenia jasminoides"
            txtDescription.text = "Certain nutrients, in relatively small amounts, are required for healthy plant growth. Deficiencies can cause tip chlorosis or necrosis or cause foliage to discolor, fade, distort, or become spotted, sometimes in a characteristic pattern that can be recognized to identify the cause. Fewer leaves, flowers, and fruit may be produced, and these can develop later than normal and remain undersized. More severely deficient plants become stunted and exhibit dieback. Nutrient deficiencies rarely occur in most woody landscape plants. When they do occur, nitrogen and iron are the most commonly seen deficiencies. However, nutrient deficiency symptoms usually are not due to a deficiency in the soil but are caused by conditions that reduce a plant's access to them. Poor root growth caused by water-logged soil, root diseases, and nematodes can cause deficiency symptoms. Commercial laboratories can conduct foliage tests or soil analysis to verify deficiencies."
        } else if (lblDiagnosis.text == "gardenia good") {
            lblDiagnosis.text = "No Issues Detected"
            lblPlantName.text = "Gardenia"
            lblLatinName.text = "Gardenia jasminoides"
            txtDescription.text = "Gardenias are known for waxy white fragrant blooms upon large dark green leaves. Plants are grown as evergreen shrubs, groundcovers or as a formal standard. They can also be espaliered. They can grow up to 6 feet tall. \n Gardenias are best grown in rich organic soils with acidic pH. They require well-drained soil. Avoid crowding with other plants and use surface cultivation. Plants do best in partial shade in hot inland valleys. Avoid high salt conditions. Mulches may help conserve water and decrease soil temperature fluctuations."
        }
    }
    @IBOutlet weak var txtDescription: UITextView!

    @IBOutlet weak var imgResultPhoto: UIImageView!
    
    @IBOutlet weak var lblDiagnosis: UILabel!
    
    @IBOutlet weak var lblPlantName: UILabel!
    
    @IBOutlet weak var lblLatinName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateTaken: UILabel!
}

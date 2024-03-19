//
//  WeightStrModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/03/24.
//

import Foundation
import UIKit

struct WeightImgModel {
    
    var img: UIImage!
    
    init(img: UIImage!) {
        self.img = img
    }
    
    static var weightModel : [WeightImgModel] = [
    
        WeightImgModel(img: UIImage(named: "W1")),
        WeightImgModel(img: UIImage(named: "W2")),
        WeightImgModel(img: UIImage(named: "W3")),
        WeightImgModel(img: UIImage(named: "W4"))
        
    ]
}

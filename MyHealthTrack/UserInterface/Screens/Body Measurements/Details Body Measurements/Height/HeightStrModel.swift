//
//  HeightStrModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/03/24.
//

import Foundation
import UIKit

struct HeightImgModel {
    
    var img: UIImage!
    
    init(img: UIImage!) {
        self.img = img
    }
    
    static var heightModel : [HeightImgModel] = [
    
        HeightImgModel(img: UIImage(named: "W1")),
        HeightImgModel(img: UIImage(named: "W2")),
        HeightImgModel(img: UIImage(named: "W3")),
        HeightImgModel(img: UIImage(named: "W4"))
        
    ]
}

//
//  StaticDataModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 27/02/24.
//

import Foundation
import UIKit

struct StaticModel {
    
    var img: UIImage?
    
    init(img: UIImage? = nil) {
        self.img = img
    }
    
    
    static var RWDModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named:"RW1")),
        StaticModel(img: UIImage(named:"RW2")),
        StaticModel(img: UIImage(named:"RW3")),
        StaticModel(img: UIImage(named:"RW4"))
    
    ]
    
    static var StepsModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "Steps1")),
        StaticModel(img: UIImage(named: "Steps2")),
        StaticModel(img: UIImage(named: "Steps3"))
    
    ]
    
    
    static var ActiveEnergyModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "Active1")),
        StaticModel(img: UIImage(named: "Active2")),
        StaticModel(img: UIImage(named: "Active3"))
    
    ]
    
    
    static var RestingEnergyModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "Resting1"))
    
    ]
    
    static var StairClimbedModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "StairsClimbed"))
    
    ]
    
    
    static var HeartModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "Heart1")),
        StaticModel(img: UIImage(named: "Heart2")),
        StaticModel(img: UIImage(named: "Heart3"))
    
    ]
    
    
    
    static var AnxietyModel: [StaticModel] = [
    
        StaticModel(img: UIImage(named: "Anxiety1")),
        StaticModel(img: UIImage(named: "Anxiety2")),
        StaticModel(img: UIImage(named: "Anxiety3"))
    
    ]
   
    
    
}


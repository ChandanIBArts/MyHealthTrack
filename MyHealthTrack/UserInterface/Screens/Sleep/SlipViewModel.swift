//
//  SlipViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import Foundation
import UIKit

struct ImgStore {
    
    var img: UIImage?
    
    init(img: UIImage? = nil) {
        self.img = img
    }
    
    static var SleepImg: [ImgStore] = [
        ImgStore(img: UIImage(named: "Sleep1")),
        ImgStore(img: UIImage(named: "Sleep2")),
        ImgStore(img: UIImage(named: "Sleep3"))
    ]
    
}

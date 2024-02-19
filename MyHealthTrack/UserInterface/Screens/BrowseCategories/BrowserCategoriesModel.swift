//
//  BrowserCategoriesModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import Foundation
import UIKit

class BrowseRecords {
    var title: String?
    var image: UIImage?
    
    init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
    
    static var browsercategoriesRecord: [BrowseRecords] = [
        BrowseRecords(title: "Activity",image: UIImage(named: "Activity.png")),
        BrowseRecords(title: "Heart",image: UIImage(named: "heart.png")),
        BrowseRecords(title: "Body measurement",image: UIImage(named: "body-measurement.png")),
        BrowseRecords(title: "Vitals",image: UIImage(named: "vitals.png")),
        BrowseRecords(title: "Mental",image: UIImage(named: "mental.png")),
        BrowseRecords(title: "Mobility",image: UIImage(named: "Mobility.png")),
        BrowseRecords(title: "Respiratory",image: UIImage(named: "respiratory.png")),
        BrowseRecords(title: "Sleep",image: UIImage(named: "sleep.png")),
        BrowseRecords(title: "Hearing",image: UIImage(named: "hearing.png"))
       // BrowseRecords(title: "Symptoms",image: UIImage(named: "symptoms.png")),
    ]
    
}

//
//   MentalWellbeingModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import Foundation

class MentalRecord {
    
    var title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
    
    static var mentalData : [MentalRecord] = [
    
   // MentalRecord(title: "Anxiety Risk"),
    MentalRecord(title: "Depression Risk"),
    MentalRecord(title: "Exercise Minutes"),
    MentalRecord(title: "Mindful Minutes"),
    MentalRecord(title: "Sleep"),
    MentalRecord(title: "State of Mind"),
    MentalRecord(title: "Time In Daylight"),
    ]
    
}

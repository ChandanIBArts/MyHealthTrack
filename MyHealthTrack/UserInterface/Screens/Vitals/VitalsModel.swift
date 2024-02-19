//
//  VitalsModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/01/24.
//

import Foundation
struct VitalsRecord {
    
    var title: String?
    var data: String?
    var unit: String?
    var time: String?
    var date: String?
    
    init(title: String? = nil, data: String? = nil, unit: String? = nil, time: String? = nil, date: String? = nil) {
        self.title = title
        self.data = data
        self.unit = unit
        self.time = time
        self.date = date
    }
}

struct strVitalsRecord {
    
    var strData: String?
    
    init(strData: String? = nil) {
        self.strData = strData
    }
   
static var strVitalsData : [strVitalsRecord] = [

    strVitalsRecord(strData: "Anxiety Risk"),
    strVitalsRecord(strData: "Depression Risk"),
    strVitalsRecord(strData: "Exercise Minutes"),
    strVitalsRecord(strData: "Mindful Minutes"),
    strVitalsRecord(strData: "Sleep"),
    strVitalsRecord(strData: "State of Mind"),
    strVitalsRecord(strData: "Time In Daylight"),
    ]
}

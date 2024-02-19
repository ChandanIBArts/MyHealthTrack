//
//  BodyMeasurementsModel.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import Foundation
struct BodyRecord {
    var title: String?
    var data : String?
    var unit : String?
    var time : String?
    var date : String?
    
    init(title: String? = nil, data: String? = nil, unit: String? = nil, time: String? = nil, date: String? = nil) {
        self.title = title
        self.data = data
        self.unit = unit
        self.time = time
        self.date = date
    }
    
}

struct strBodyRecord {
    
    var strString: String?
    
    init(strString: String? = nil) {
        self.strString = strString
    }
    
    static var strstrBodyRecord : [strBodyRecord] = [
        strBodyRecord(strString: "Basal Body Temperature"),
        strBodyRecord(strString: "Body Fat Percentage"),
        strBodyRecord(strString: "Body Mass Index"),
        strBodyRecord(strString: "Body Temperature")
    ]
    
}

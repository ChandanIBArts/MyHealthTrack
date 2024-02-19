//
//  HearingModel.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import Foundation
struct HearRateRecord {
   
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

struct StrHearRateRecord {
    
    var strData: String?
   
    
    init(strData: String? = nil) {
        self.strData = strData
    }
   
    static var strheartData : [StrHearRateRecord] = [
        StrHearRateRecord(strData: "Anxiety Risk"),
        StrHearRateRecord(strData: "Depression Risk"),
        StrHearRateRecord(strData: "Exercise Minutes"),
        StrHearRateRecord(strData: "Mindful Minutes"),
        StrHearRateRecord(strData: "Sleep"),
        StrHearRateRecord(strData: "State of Mind"),
        StrHearRateRecord(strData: "Time In Daylight"),
  ]
}

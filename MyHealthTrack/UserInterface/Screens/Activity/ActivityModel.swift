//
//  ActivityModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 12/01/24.
//

import Foundation

struct ActivityRecord {
    
    var title: String?
    var datavalu: String?
    var dataUnit: String?
    var time: String?
    var date: String?
    
    init(title: String? = nil, datavalu: String? = nil, dataUnit: String? = nil, time: String? = nil, date: String? = nil) {
        self.title = title
        self.datavalu = datavalu
        self.dataUnit = dataUnit
        self.time = time
        self.date = date
    }
    
    
}

struct strActivityRecord {
    
    var strData: String?
    
    init(strData: String? = nil) {
        self.strData = strData
    }
   
static var strActivityData : [strActivityRecord] = [
    strActivityRecord(strData: "Active Energy"),
    strActivityRecord(strData: "Activity"),
    strActivityRecord(strData: "Cardio Fitness"),
    strActivityRecord(strData: "Cardio Recovery"),
    strActivityRecord(strData: "Cycling Cadence"),
    strActivityRecord(strData: "Cycling Distance"),
    strActivityRecord(strData: "Cycling Power"),
    strActivityRecord(strData: "Cycling Speed")
  ]
}



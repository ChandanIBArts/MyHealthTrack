//
//  MobilityModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import Foundation

struct MobilityRecord {
    
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

struct strMobilityRecord {
    
    var strData: String?
    
    init(strData: String? = nil) {
        self.strData = strData
    }
    
static var strMobilityData : [strMobilityRecord] = [

    strMobilityRecord(strData: "Cardio Fitness"),
    strMobilityRecord(strData: "Ground Contact Time"),
    strMobilityRecord(strData: "Running Stride Length"),
    strMobilityRecord(strData: "Six-Minute Walk"),
    strMobilityRecord(strData: "Stair Speed: Down"),
    strMobilityRecord(strData: "Stair Speed: Up"),
    strMobilityRecord(strData: "Vertical Oscillation"),
    strMobilityRecord(strData: "Walking Steadiness Notifications")
    
  ]
}

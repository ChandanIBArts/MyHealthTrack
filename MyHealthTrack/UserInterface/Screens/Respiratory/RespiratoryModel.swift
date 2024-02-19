//
//  RespiratoryModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import Foundation


struct strRespiratoryRecord {
    
    var strData: String?
    
    init(strData: String? = nil) {
        self.strData = strData
    }
    
static var strRespiratoryData : [strRespiratoryRecord] = [

    strRespiratoryRecord(strData: "Cardio Fitness"),
    strRespiratoryRecord(strData: "Ground Contact Time"),
    strRespiratoryRecord(strData: "Running Stride Length"),
    strRespiratoryRecord(strData: "Six-Minute Walk"),
    strRespiratoryRecord(strData: "Stair Speed: Down"),
    strRespiratoryRecord(strData: "Stair Speed: Up"),
    strRespiratoryRecord(strData: "Vertical Oscillation"),
    strRespiratoryRecord(strData: "Walking Steadiness Notifications")
    
  ]
}

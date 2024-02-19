//
//  HearingModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/01/24.
//

import Foundation
struct strHearingRecord {
    
    var strData: String?
    
    init(strData: String? = nil) {
        self.strData = strData
    }
    
static var strHearingData : [strHearingRecord] = [

    strHearingRecord(strData: "Audiogram"),
    strHearingRecord(strData: "Environmental Sound Lavels"),
    strHearingRecord(strData: "Environmental Sound Reduction"),
    strHearingRecord(strData: "Headphone Notifications"),
    strHearingRecord(strData: "Noise Notifications")
    
  ]
}

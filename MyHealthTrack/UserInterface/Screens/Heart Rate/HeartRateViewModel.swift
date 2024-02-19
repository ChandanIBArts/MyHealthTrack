//
//  HearingViewModel.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import Foundation
import HealthKit

class HeartHealthKitManager {
    
    let healthStore = HKHealthStore()
    var arr = [HearRateRecord]()
    var hTime: String?
    var hDate: String?
    
    func requestAuthorization(comp: @escaping (([HearRateRecord]?)->Void)){
        
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        // Request authorization to read heart rate data
        healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { [self] (success, error) in
            if success {
                // Authorization granted, you can now access heart rate data
                self.calldata{
                    mod in
                    comp(mod)
                }
                
                print("Error")
                // Define a query to fetch the most recent heart rate sample
                
                
            } else {
                // Handle the case where the user denied access or there was an error
                print("HealthKit authorization denied or error: \(String(describing: error))")
            }
        }
        
    }
    
    
    func calldata(comp: @escaping (([HearRateRecord]?)->Void)){
        
        self.heartRat{
            mod in
            comp(mod)
        }
        
    }
    
    
    func heartRat(comp: @escaping (([HearRateRecord]?)->Void)){
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: stepsQuantityType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, samples, error) in
            if let error = error {
                // Handle error
                print("Error querying steps data: \(error)")
                return
            }
            
            // Process retrieved samples (steps data)
            if let stepSamples = samples as? [HKQuantitySample] {
                
                for sample in stepSamples {
                    let valus = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                    let date = sample.startDate
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    dateFormatter.timeStyle = .medium
                    let formattedDate = dateFormatter.string(from: date)
                    print(date)
                    if let components = self.getComponents(from: formattedDate) {
                        let (day, month, year, hour, minute) = components
                        print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                        
                        self.hDate = "\(day).\(month).\(year)"
                        let fTime = "\(hour):\(minute)"
                        
                        if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                            print("Converted to AM/PM: \(ampmTime)")
                            self.hTime = ampmTime
                           
                        } else {
                            print("Invalid time string")
                        }
                        
                    } else {
                        print("Invalid date string")
                    }
    
                    var model = HearRateRecord()
                    model.title = "Heart Rate"
                    model.data = String(valus)
                    model.unit = "bpm"
                    model.date = self.hDate
                    model.time = self.hTime
                    self.arr.append(model)
                    comp(self.arr)
                }
            }
        }
        
        // Execute the query
        healthStore.execute(query)
        
    }
    
    func getComponents(from dateString: String) -> (Int, Int, Int, Int, Int)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy 'at' hh:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            let day = components.day ?? 0
            let month = components.month ?? 0
            let year = components.year ?? 0
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            
            return (day, month, year, hour, minute)
        }

        return nil
    }
    
    func convertToAMPM(timeString24Hour: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if let date = formatter.date(from: timeString24Hour) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }
        
        return nil
    }
    
    
}
        

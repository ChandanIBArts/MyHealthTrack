//
//  VitalsViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/01/24.
//

import Foundation
import HealthKit

class VitalsHealthKitManager {
    let vitalshealthStore = HKHealthStore()
    var arr = [VitalsRecord]()
    var vTime: String?
    var vDate: String?

    func requestAuthorization(comp: @escaping (([VitalsRecord]?)->Void)) {
        if HKHealthStore.isHealthDataAvailable() {
            let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

            //let typesToRead: Set<HKObjectType> = [heartRateType]

            vitalshealthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { (success, error) in
                if success {
                    // Authorization granted, you can now access health data.
                    self.vitalsData{
                    mod in
                    comp(mod)
                }
                } else {
                    // Authorization failed, handle the error.
                    print("HealthKit authorization failed. Error: \(String(describing: error))")
                }
            }
        } else {
            // Health data is not available on this device.
            print("Health data is not available on this device.")
        }
    }
    
    func calldata(comp: @escaping (([VitalsRecord]?)->Void)){
        
        self.vitalsData{
            mod in
            comp(mod)
        }
        
    }
    

    func vitalsData(comp: @escaping (([VitalsRecord]?)->Void)) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let query = HKSampleQuery(sampleType: heartRateType, 
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
            if let error = error {
                // Handle error
                print("Error querying steps data: \(error)")
                return
            }
            // Process retrieved samples (steps data)
            if let samples = results as? [HKQuantitySample], let heartRateSample = samples.first {
                let heartRate = heartRateSample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                let date = heartRateSample.startDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.vDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.vTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                var model = VitalsRecord()
                model.title = "Heart Rate"
                model.data = String(heartRate)
                model.unit = "bpm"
                model.date = self.vDate
                model.time = self.vTime
                self.arr.append(model)
                comp(self.arr)
            } else {
                // Handle error
                print("Error reading heart rate data: \(String(describing: error))")
            }
        }

        vitalshealthStore.execute(query)
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

// Example usage
//let vitalshealthStore = HealthKitManager()
//healthKitManager.requestAuthorization()

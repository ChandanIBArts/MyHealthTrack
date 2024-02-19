//
//  BodyMeasurementsViewModel.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import Foundation
import HealthKit

class BodyHealthKitManager {

    let bodyhealthStore = HKHealthStore()

    var arr = [BodyRecord]()
    var bTime: String?
    var bDate: String?
    
    func requestAuthorization(comp: @escaping (([BodyRecord]?)->Void)) {
        if HKHealthStore.isHealthDataAvailable() {
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let typesToRead: Set<HKObjectType> = [heightType, bodyMassType]

        bodyhealthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                // Authorization successful, you can now access health data
                self.calldata{
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
    
    
    
    func calldata(comp: @escaping (([BodyRecord]?)->Void)){
        
        self.height{
            mod in
            comp(mod)
        }
        self.waite{
            mod in
            comp(mod)
        }
        
    }

    func height(comp: @escaping (([BodyRecord]?)->Void)) {
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!

        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let heightSample = samples.first {
                let height = heightSample.quantity.doubleValue(for: HKUnit.meter())
                let date = heightSample.startDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.bDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.bTime = ampmTime
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                
                print("Height: \(height * 100) centimeter")
                var model = BodyRecord()
                model.title = "Height"
                model.data = String(height * 100)
                model.unit = "cm"
                model.date = self.bDate
                model.time = self.bTime
                self.arr.append(model)
                comp(self.arr)
            } else {
                // Handle error
                print("Error reading height data: \(String(describing: error))")
            }
        }

        bodyhealthStore.execute(query)
    }
   
    
    func waite(comp: @escaping (([BodyRecord]?)->Void)){
        
        let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!

        let query = HKSampleQuery(sampleType: bodyMassType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let bodyMassSample = samples.first {
                let bodyMass = bodyMassSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                let date = bodyMassSample.startDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.bDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.bTime = ampmTime
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                
                
                print("Body Mass: \(bodyMass) kilograms")
                var model = BodyRecord()
                model.title = "Weight"
                model.data = String(bodyMass)
                model.unit = "kg"
                model.date = self.bDate
                model.time = self.bTime
                self.arr.append(model)
                print(self.arr)
                comp(self.arr)
            } else {
                // Handle error
                print("Error reading body mass data: \(String(describing: error))")
            }
        }

        bodyhealthStore.execute(query)
        
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


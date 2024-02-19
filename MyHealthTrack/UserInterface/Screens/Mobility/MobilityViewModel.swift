//
//  MobilityViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import Foundation
import HealthKit

class MobilityHealthKitManager {
  
    let mobilityhealthStore = HKHealthStore()
   
    var arr = [MobilityRecord]()
    var mTime: String?
    var mDate: String?
    
    func requestAuthorization(comp: @escaping (([MobilityRecord]?)->Void)) {
        if HKHealthStore.isHealthDataAvailable() {
           // let walkingSteadiness = HKQuantityType.quantityType(forIdentifier: .appleWalkingSteadiness)!
            let DoubleSupport = HKQuantityType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
            let walkingAsymmetry = HKQuantityType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
            let walkingSpeed = HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!
            let walkingStepLength = HKQuantityType.quantityType(forIdentifier: .walkingStepLength)!
            
            let typesToRead: Set<HKObjectType> = [/*walkingSteadiness,*/ DoubleSupport, walkingAsymmetry, walkingSpeed, walkingStepLength]

            mobilityhealthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
                if success {
                    // Authorization granted, you can now access health data.
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
    
    
    func calldata(comp: @escaping (([MobilityRecord]?)->Void)){
    /*self.readwalkingSteadinessData{
        mod in
        comp(mod)
    }*/
        self.readDoubleSupportData{
            mod in
            comp(mod)
        }
        self.readwalkingAsymmetryData{
            mod in
            comp(mod)
        }
        self.readwalkingSpeedData{
            mod in
            comp(mod)
        }
        self.readWalkingStepLengthAData{
            mod in
            comp(mod)
        }
    }
    
    /*
      func readwalkingSteadinessData(comp: @escaping (([MobilityRecord]?)->Void)) {
          let countType = HKQuantityType.quantityType(forIdentifier: .appleWalkingSteadiness)!

          let query = HKSampleQuery(sampleType: countType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
              if let samples = results as? [HKQuantitySample], let countSample = samples.first {
                  let letestData = countSample.quantity.doubleValue(for: HKUnit.second())
                  let date = countSample.endDate
                  print(" \(letestData) seconds")
                  print(date)
              } else {
                  // Handle error or create a new step count sample if it doesn't exist
                  print("Error reading step count data: \(String(describing: error))")
              }
          }

        mobilityhealthStore.execute(query)
      }
   */
    
    func readDoubleSupportData(comp: @escaping (([MobilityRecord]?)->Void)) {
        let countType = HKQuantityType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!

        let query = HKSampleQuery(sampleType: countType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let countSample = samples.first {
                let letestData = countSample.quantity.doubleValue(for: HKUnit.percent())
                let date = countSample.endDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.mDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.mTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                var model = MobilityRecord()
                model.title = "Double Support Time"
                model.data = String(format: "%.2f", letestData * 100)
                model.unit = "%"
                model.date = self.mDate
                model.time = self.mTime
                self.arr.append(model)
                comp(self.arr)
                
                
                print("DoubleSupport: \(letestData * 100) %")
                print(date)
            } else {
                // Handle error or create a new step count sample if it doesn't exist
                print("Error reading step count data: \(String(describing: error))")
            }
        }

        mobilityhealthStore.execute(query)
    }
    
    func readwalkingAsymmetryData(comp: @escaping (([MobilityRecord]?)->Void)) {
        
        let countType = HKQuantityType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!

        let query = HKSampleQuery(sampleType: countType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let countSample = samples.first {
                let letestData = countSample.quantity.doubleValue(for: HKUnit.percent())
                let date = countSample.endDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.mDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.mTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                var model = MobilityRecord()
                model.title = "Walking Asymmetry"
                model.data = String(format: "%.2f", letestData)
                model.unit = "%"
                model.date = self.mDate
                model.time = self.mTime
                self.arr.append(model)
                comp(self.arr)
                
                
                
                
                print("walkingAsymmetry: \(letestData * 100) %")
                print(date)
            } else {
                // Handle error or create a new step count sample if it doesn't exist
                print("Error reading step count data: \(String(describing: error))")
            }
        }

        mobilityhealthStore.execute(query)
        
    }
    
    func readwalkingSpeedData(comp: @escaping (([MobilityRecord]?)->Void)) {
        
        let countType = HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!

        let query = HKSampleQuery(sampleType: countType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let countSample = samples.first {
                let letestData = countSample.quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
                let date = countSample.endDate
               
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.mDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.mTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                var model = MobilityRecord()
                model.title = "Walking Speed"
                let mnt = letestData * 60
                let hrs = mnt * 60
                let km = hrs / 1000
                print (String(format: "%.2f", km))
                model.data = String(format: "%.2f", km)
                model.unit = "KM/H"
                model.date = self.mDate
                model.time = self.mTime
                self.arr.append(model)
                comp(self.arr)
                print("walkingSpeed: \(letestData) meters per second")
                print(date)
            } else {
                // Handle error or create a new step count sample if it doesn't exist
                print("Error reading step count data: \(String(describing: error))")
            }
        }

        mobilityhealthStore.execute(query)
        
    }
        
    func readWalkingStepLengthAData(comp: @escaping (([MobilityRecord]?)->Void)) {
        let countType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength)!

        let query = HKSampleQuery(sampleType: countType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let countSample = samples.first {
                let stepCount = countSample.quantity.doubleValue(for: HKUnit.meter())
                let date = countSample.endDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.mDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.mTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                var model = MobilityRecord()
                model.title = "Walking Step Length"
                model.data = String(format: "%.2f", stepCount * 100)
                model.unit = "cm"
                model.date = self.mDate
                model.time = self.mTime
                self.arr.append(model)
                comp(self.arr)
                print(self.arr)
                print("WalkingStepLength: \(stepCount * 100) cm, Date: \(date)")
            } else {
                // Handle error or create a new step count sample if it doesn't exist
                print("Error reading step count data: \(String(describing: error))")
            }
        }

        mobilityhealthStore.execute(query)
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


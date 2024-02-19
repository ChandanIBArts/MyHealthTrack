//
//  ActivityViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 12/01/24.
//

import Foundation
import HealthKit

class HealthKitmanager {
    
    let healthStore = HKHealthStore()
    
    var arr = [ActivityRecord]()
    var aTime: String?
    var aDate: String?
    static var dailySteps: String?
    static var dailyRunningAndWalkingDistance: String?
    static var dailyActiveEnergy: String?
    static var dailyRestingEnergy: String?
    static var dailyStairClimbedStep: String?
    
    func requestAuthorization(comp: @escaping (([ActivityRecord]?)->Void)) {
        if HKHealthStore.isHealthDataAvailable() {
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
            let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            let restingEnergyType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
            let stairsClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!
            let typesToRead: Set<HKObjectType> = [stepType, activeEnergyType, distanceType, restingEnergyType,stairsClimbedType]
            
            healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
                if success {
                    // Authorization granted, you can now access health data.
                    self.readHealthData{
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
    
    func readHealthData(comp: @escaping (([ActivityRecord]?)->Void)) {
        // Step count
        self.readTotalStepCount{
            mod in
            comp(mod)
        }
        // Active energy
        self.readActiveEnergy{
            mod in
            comp(mod)
        }
        
        // Distance (Walking + Running)
        self.readWalkingRunningDistance{
            mod in
            comp(mod)
        }
        
        // Resting energy
        self.readRestingEnergy{
            mod in
            comp(mod)
        }
        
        //Stairs Climbed
        self.readStairsClimbed{
            mod in
            comp(mod)
        }
    }
    
    
   /*
    func readStepCountData(comp: @escaping (([ActivityRecord]?)->Void)) {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let query = HKSampleQuery(sampleType: stepCountType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let samples = results as? [HKQuantitySample], let stepCountSample = samples.first {
                let stepCount = stepCountSample.quantity.doubleValue(for: HKUnit.count())
                let date = stepCountSample.startDate
        
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                let formattedDate = dateFormatter.string(from: date)
                print(date)
                if let components = self.getComponents(from: formattedDate) {
                    let (day, month, year, hour, minute) = components
                    print("Day: \(day), Month: \(month), Year: \(year), Hour: \(hour), Minute: \(minute)")
                    
                    self.aDate = "\(day).\(month).\(year)"
                    let fTime = "\(hour):\(minute)"
                    
                    if let ampmTime = self.convertToAMPM(timeString24Hour: fTime) {
                        print("Converted to AM/PM: \(ampmTime)")
                        self.aTime = ampmTime
                       
                    } else {
                        print("Invalid time string")
                    }
                    
                } else {
                    print("Invalid date string")
                }
                print(stepCount)
                var model = ActivityRecord()
                model.title = "Steps"
                model.datavalu = String(stepCount)
                model.dataUnit = "Steps"
                model.date = self.aDate
                model.time = self.aTime
                self.arr.append(model)
                comp(self.arr)
            } else {
                // Handle error or create a new step count sample if it doesn't exist
                print("Error reading step count data: \(String(describing: error))")
            }
        }

        healthStore.execute(query)
    }
*/
    func readTotalStepCount(comp: @escaping (([ActivityRecord]?)->Void)) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        // self.readQuantityTypeData(type: stepType, unit: HKUnit.count())
        
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            if let result = result, let sum = result.sumQuantity() {
                let value = sum.doubleValue(for: HKUnit.count())
                
                var model = ActivityRecord()
                model.datavalu = String(Int(value))
                HealthKitmanager.dailySteps = String(Int(value))
                model.dataUnit = "Steps"
                model.title = "Steps"
                self.arr.append(model)
            } else {
                // Handle error
                print("Error reading \(stepType.identifier): \(String(describing: error))")
            }
        }
        healthStore.execute(query)
    }
   
    func readActiveEnergy(comp: @escaping (([ActivityRecord]?)->Void)) {
        let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            if let result = result, let sum = result.sumQuantity() {
                let value = sum.doubleValue(for: HKUnit.kilocalorie())
                var model = ActivityRecord()
                model.datavalu = String(format: "%.2f", value)
                HealthKitmanager.dailyActiveEnergy = String(format: "%.2f", value)
                model.dataUnit = HKUnit.kilocalorie().unitString
                model.title = "Active Energy"
                self.arr.append(model)
                comp(self.arr)
                print("readActiveEnergy : \(value)  \(HKUnit.kilocalorie().unitString)")
                
            } else {
                print("Error reading \(activeEnergyType.identifier): \(String(describing: error))")
            }
        }
        
        healthStore.execute(query)
        
    }
    
    func readWalkingRunningDistance(comp: @escaping (([ActivityRecord]?)->Void)) {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            if let result = result, let sum = result.sumQuantity() {
                let value = sum.doubleValue(for: HKUnit.meterUnit(with: .kilo))
                
                var model = ActivityRecord()
                model.datavalu = String(format: "%.2f", value)
                HealthKitmanager.dailyRunningAndWalkingDistance = String(format: "%.2f", value)
                model.dataUnit = HKUnit.meterUnit(with: .kilo).unitString
                model.title = "Walking + Running Distance"
                self.arr.append(model)
                comp(self.arr)
                print("readWalkingRunningDistance : \(value)  \(HKUnit.meterUnit(with: .kilo))")
                
            } else {
                
                print("Error reading \(distanceType.identifier): \(String(describing: error))")
            }
        }
        
        healthStore.execute(query)
        
        
    }
    
    func readRestingEnergy(comp: @escaping (([ActivityRecord]?)->Void)) {
        let restingEnergyType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        // self.readQuantityTypeData(type: restingEnergyType, unit: HKUnit.kilocalorie())
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: restingEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            if let result = result, let sum = result.sumQuantity() {
                let value = sum.doubleValue(for: HKUnit.kilocalorie())
                var model = ActivityRecord()
                model.datavalu = String(format: "%.2f", value)
                HealthKitmanager.dailyRestingEnergy = String(format: "%.2f", value)
                model.dataUnit = HKUnit.kilocalorie().unitString
                model.title = "Resting Energy"
                self.arr.append(model)
                comp(self.arr)
                print("readRestingEnergy : \(value)  \(HKUnit.kilocalorie().unitString)")
                
            } else {
                print("Error reading \(restingEnergyType.identifier): \(String(describing: error))")
            }
        }

        healthStore.execute(query)
    }
    
    func readStairsClimbed(comp: @escaping (([ActivityRecord]?)->Void)) {
        // Define the type of data to query (flights climbed)
        guard let flightsClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            print("Flights climbed type is not available")
            return
        }
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: flightsClimbedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Error fetching flights climbed data: \(error?.localizedDescription ?? "")")
                return
            }
            // Print the flights climbed count
            let flightsClimbedCount = sum.doubleValue(for: HKUnit.count())
            
            var model = ActivityRecord()
            model.datavalu = String(Int(flightsClimbedCount))
            HealthKitmanager.dailyStairClimbedStep = String(Int(flightsClimbedCount))
            model.dataUnit = HKUnit.count().unitString
            model.title = "Stairs Climbed"
            self.arr.append(model)
            comp(self.arr)
            print("Flights climbed count: \(flightsClimbedCount)")
        }

        // Execute the query
        HKHealthStore().execute(query)
        
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

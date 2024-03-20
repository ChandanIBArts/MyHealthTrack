//
//  DetailsWalkingStepLengthViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import Foundation
import HealthKit
import DGCharts
import Charts

class DetailsWalkingStepLengthHealthKitManager{
    
    let healthStore = HKHealthStore()

    func requestAuthorization(for types: Set<HKSampleType>, completion: @escaping (Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: nil, read: types) { (success, error) in
            completion(success, error)
        }
    }
    
    //MARK: Daily Data
    func fetchDailyWalkingSpeed(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

       

        // Set the interval to fetch data
        let interval = DateComponents(hour: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .day, value: -1, to: endDate) else {
            completion([])
            return
        }
        // Set the predicate to fetch data for the last one year
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create the query to fetch the walking speed data
        let query = HKStatisticsCollectionQuery(quantityType: walkingStepLengthType,
                                                quantitySamplePredicate: predicate,
                                                options: [.discreteAverage],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Handle the query results
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var walkingStepLengthData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: now) { statistics, stop in
                if let averageSpeed = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let speed = averageSpeed.doubleValue(for: HKUnit.meter())
                    walkingStepLengthData.append((date, speed))
                }
            }

            completion(walkingStepLengthData)
        }

        // Execute the query
        healthStore.execute(query)
    }
    
    //MARK: Weekly Data
    func fetchWeeklyWalkingSpeed(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

       

        // Set the interval to fetch data
        let interval = DateComponents(day: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .weekOfMonth, value: -1, to: endDate) else {
            completion([])
            return
        }
        // Set the predicate to fetch data for the last one year
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create the query to fetch the walking speed data
        let query = HKStatisticsCollectionQuery(quantityType: walkingStepLengthType,
                                                quantitySamplePredicate: predicate,
                                                options: [.discreteAverage],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Handle the query results
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var walkingStepLengthData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: now) { statistics, stop in
                if let averageSpeed = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let speed = averageSpeed.doubleValue(for: HKUnit.meter())
                    walkingStepLengthData.append((date, speed))
                }
            }

            completion(walkingStepLengthData)
        }

        // Execute the query
        healthStore.execute(query)
    }
    
    
    
    
    //MARK: Monthly Data
    func fetchMonthlyWalkingSpeed(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

       

        // Set the interval to fetch data
        let interval = DateComponents(day: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .month, value: -1, to: endDate) else {
            completion([])
            return
        }
        // Set the predicate to fetch data for the last one year
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create the query to fetch the walking speed data
        let query = HKStatisticsCollectionQuery(quantityType: walkingStepLengthType,
                                                quantitySamplePredicate: predicate,
                                                options: [.discreteAverage],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Handle the query results
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var walkingStepLengthData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: now) { statistics, stop in
                if let averageSpeed = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let speed = averageSpeed.doubleValue(for: HKUnit.meter())
                    walkingStepLengthData.append((date, speed))
                }
            }

            completion(walkingStepLengthData)
        }

        // Execute the query
        healthStore.execute(query)
    }
    
    
    
    //MARK: halfYearly Data
    func fetchHalfYearlyWalkingSpeed(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

       

        // Set the interval to fetch data
        let interval = DateComponents(month: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .month, value: -6, to: endDate) else {
            completion([])
            return
        }
        // Set the predicate to fetch data for the last one year
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create the query to fetch the walking speed data
        let query = HKStatisticsCollectionQuery(quantityType: walkingStepLengthType,
                                                quantitySamplePredicate: predicate,
                                                options: [.discreteAverage],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Handle the query results
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var walkingStepLengthData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: now) { statistics, stop in
                if let averageSpeed = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let speed = averageSpeed.doubleValue(for: HKUnit.meter())
                    walkingStepLengthData.append((date, speed))
                }
            }

            completion(walkingStepLengthData)
        }

        // Execute the query
        healthStore.execute(query)
    }
    

    
    
    //MARK: Yearly Data
    func fetchYearlyWalkingSpeed(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

       

        // Set the interval to fetch data
        let interval = DateComponents(month: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .year, value: -1, to: endDate) else {
            completion([])
            return
        }
        // Set the predicate to fetch data for the last one year
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create the query to fetch the walking speed data
        let query = HKStatisticsCollectionQuery(quantityType: walkingStepLengthType,
                                                quantitySamplePredicate: predicate,
                                                options: [.discreteAverage],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        // Handle the query results
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var walkingStepLengthData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: now) { statistics, stop in
                if let averageSpeed = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let speed = averageSpeed.doubleValue(for: HKUnit.meter())
                    walkingStepLengthData.append((date, speed))
                }
            }

            completion(walkingStepLengthData)
        }

        // Execute the query
        healthStore.execute(query)
    }
  
    
}

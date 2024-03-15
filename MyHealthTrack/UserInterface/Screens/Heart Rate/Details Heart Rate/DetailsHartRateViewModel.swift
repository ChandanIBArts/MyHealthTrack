//
//  DetailsHartRateModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/02/24.
//

import Foundation
import HealthKit
import DGCharts
import Charts

class DetailsHeartRateHealthKitManager{
    
    let healthStore = HKHealthStore()

    //stepCount
    //HKUnit.count()
    
    //MARK: Daily Hrs Data
    func requestDailyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchDailyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

        let interval = DateComponents(hour: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .day, value: -1, to: endDate) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stepCountData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = sum.doubleValue(for: HKUnit.count())
                    stepCountData.append((date, steps))
                }
            }

            completion(stepCountData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Weak Data
    func requestWeeklyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchWeeklyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

        let interval = DateComponents(day: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .weekOfMonth, value: -1, to: endDate) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stepCountData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = sum.doubleValue(for: HKUnit.count())
                    stepCountData.append((date, steps))
                }
            }

            completion(stepCountData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Monthly Data
    func requestMonthlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchMonthlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

        let interval = DateComponents(day: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .month, value: -1, to: endDate) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stepCountData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = sum.doubleValue(for: HKUnit.count())
                    stepCountData.append((date, steps))
                }
            }

            completion(stepCountData)
        }

        healthStore.execute(query)
    }
    
    
    //MARK: HalfYearly Data
    func requestHalfYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchHalfYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate =  calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

        let interval = DateComponents(month: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .month, value: -6, to: now) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stepCountData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = sum.doubleValue(for: HKUnit.count())
                    stepCountData.append((date, steps))
                }
            }

            completion(stepCountData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Yearly Data
    func requestYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        let now = Date()
        guard let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            completion([])
            return
        }

        let interval = DateComponents(month: 1 )
        let endDate = now
        guard let startDate = calendar.date(byAdding: .year, value: -1, to: endDate) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stepCountData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = sum.doubleValue(for: HKUnit.count())
                    stepCountData.append((date, steps))
                }
            }

            completion(stepCountData)
        }

        healthStore.execute(query)
    }
    
}


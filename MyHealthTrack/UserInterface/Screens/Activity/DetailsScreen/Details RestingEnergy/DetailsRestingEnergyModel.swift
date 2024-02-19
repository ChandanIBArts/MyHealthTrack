//
//  DetailsRestingEnergyModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 29/01/24.
//

import Foundation
import HealthKit
import DGCharts
import Charts

class DetailsRestingEnergyHealthKitManager{
    
    let healthStore = HKHealthStore()
    
    //  basalEnergyBurned
    //  HKUnit.kilocalorie()
    //  energyBurnedType
    
    
    //MARK: Daily Hrs Data
    func requestDailyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchDailyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: energyBurnedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var restingEnergyBurnedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.kilocalorie())
                    restingEnergyBurnedData.append((date, unit))
                }
            }

            completion(restingEnergyBurnedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Weak Data
    func requestWeeklyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchWeeklyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: energyBurnedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var restingEnergyBurnedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.kilocalorie())
                    restingEnergyBurnedData.append((date, unit))
                }
            }

            completion(restingEnergyBurnedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Monthly Data
    func requestMonthlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchMonthlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: energyBurnedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var restingEnergyBurnedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.kilocalorie())
                    restingEnergyBurnedData.append((date, unit))
                }
            }

            completion(restingEnergyBurnedData)
        }

        healthStore.execute(query)
    }
    
    
    //MARK: HalfYearly Data
    func requestHalfYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchHalfYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
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
        guard let startDate = calendar.date(byAdding: .month, value: -6, to: now) else  {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: energyBurnedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var restingEnergyBurnedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.kilocalorie())
                    restingEnergyBurnedData.append((date, unit))
                }
            }

            completion(restingEnergyBurnedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Yearly Data
    func requestYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: energyBurnedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var restingEnergyBurnedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.kilocalorie())
                    restingEnergyBurnedData.append((date, unit))
                }
            }

            completion(restingEnergyBurnedData)
        }

        healthStore.execute(query)
    }
    
    
    
}
   

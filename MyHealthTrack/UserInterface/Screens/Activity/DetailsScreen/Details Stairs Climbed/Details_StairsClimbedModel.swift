//
//  Details_StairsClimbedModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 30/01/24.
//

import Foundation
import HealthKit
import DGCharts
import Charts

class DetailsStairsClimbedHealthKitManager{
    
    let healthStore = HKHealthStore()
    
    // .flightsClimbed
    // HKUnit.count()
    // stairClimbedType
    // stairClimbedData
    
 
    //MARK: Daily Hrs Data
    func requestDailyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchDailyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stairClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed ) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: stairClimbedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stairClimbedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.count())
                    stairClimbedData.append((date, unit))
                }
            }

            completion(stairClimbedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Weak Data
    func requestWeeklyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchWeeklyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stairClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: stairClimbedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stairClimbedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.count())
                    stairClimbedData.append((date, unit))
                }
            }

            completion(stairClimbedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Monthly Data
    func requestMonthlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchMonthlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stairClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: stairClimbedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stairClimbedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.count())
                    stairClimbedData.append((date, unit))
                }
            }

            completion(stairClimbedData)
        }

        healthStore.execute(query)
    }
    
    
    //MARK: HalfYearly Data
    func requestHalfYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchHalfYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stairClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
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
        guard let startDate = calendar.date(byAdding: .month, value: -6, to: now) else {
            completion([])
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: stairClimbedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stairClimbedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.count())
                    stairClimbedData.append((date, unit))
                }
            }

            completion(stairClimbedData)
        }

        healthStore.execute(query)
    }
    
    //MARK: Yearly Data
    func requestYearlyAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func fetchYearlyStepCount(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let stairClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
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

        let query = HKStatisticsCollectionQuery(quantityType: stairClimbedType,
                                                quantitySamplePredicate: predicate,
                                                options: [.cumulativeSum],
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)

        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
                completion([])
                return
            }

            var stairClimbedData: [(Date, Double)] = []

            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let sum = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let unit = sum.doubleValue(for: HKUnit.count())
                    stairClimbedData.append((date, unit))
                }
            }

            completion(stairClimbedData)
        }

        healthStore.execute(query)
    }
    
    
}
    
    /*
    var chartStairsClimbed24Hrs: [BarChartDataEntry] = []
    var chartStairsClimbed7Day: [BarChartDataEntry] = []
    var chartStairsClimbed30Day: [BarChartDataEntry] = []
    var chartStairsClimbed6M: [BarChartDataEntry] = []
    var chartStairsClimbed1Y: [BarChartDataEntry] = []
    
    var last24HrsTotal : Int? = 0
    var last7DayTotal: Int? = 0
    var last30DayTotal: Int? = 0
    var last6MTotal: Int? = 0
    var last1YTotal: Int? = 0
    
    //MARK: Last 24 Hrs Data
    func requestAuthorization24Hrs(comp: @escaping ([BarChartDataEntry])-> Void) {
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                self.queryStairsClimbed24Hrs{
                    data in
                    comp(data)
                }
            } else {
                print("HealthKit authorization failed. Error: \(String(describing: error))")
            }
        }
    }

    func queryStairsClimbed24Hrs(comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType ,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(hour: 1))

        query.initialResultsHandler = { query, statisticsCollection, error in
            guard let statisticsCollection = statisticsCollection else {
                print("Error querying Stairs Climbed: \(String(describing: error))")
                return
            }

            self.processStatisticsCollection24Hrs(statisticsCollection){
                data in
                comp(data)
            }
        }

        healthStore.execute(query)
    }

    func processStatisticsCollection24Hrs(_ statisticsCollection: HKStatisticsCollection,comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: -24, to: now)!
        statisticsCollection.enumerateStatistics(from: endDate, to: now) { statistics, _ in
            if let sum = statistics.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                let date = statistics.startDate
                self.last24HrsTotal = self.last24HrsTotal! + Int(stepCount)
                let entry = BarChartDataEntry(x: date.timeIntervalSince1970 / 1000 , y: Double(Int(stepCount)))
                self.chartStairsClimbed24Hrs.append(entry)
                comp( self.chartStairsClimbed24Hrs)
            }
        }

        // Process the chartEntries as needed (e.g., create a bar chart)
        print("Stairs Climbed Entries: \(chartStairsClimbed24Hrs)")
    }
    

    //MARK: Last 7Day Data
    func requestAuthorization7Day(comp: @escaping ([BarChartDataEntry])-> Void) {
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                self.queryStairsClimbed7Day{
                    data in
                    comp(data)
                }
            } else {
                print("HealthKit authorization failed. Error: \(String(describing: error))")
            }
        }
    }

    func queryStairsClimbed7Day(comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType ,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { query, statisticsCollection, error in
            guard let statisticsCollection = statisticsCollection else {
                print("Error querying walking + running distance: \(String(describing: error))")
                return
            }

            self.processStatisticsCollection7Day(statisticsCollection){
                data in
                comp(data)
            }
        }

        healthStore.execute(query)
    }

    func processStatisticsCollection7Day(_ statisticsCollection: HKStatisticsCollection,comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        statisticsCollection.enumerateStatistics(from: endDate, to: now) { statistics, _ in
            if let sum = statistics.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                let date = statistics.startDate
                self.last7DayTotal = self.last7DayTotal! + Int(stepCount)
                let entry = BarChartDataEntry(x: date.timeIntervalSince1970 / 100000 , y: Double(Int(stepCount)) )
                self.chartStairsClimbed7Day.append(entry)
                comp( self.chartStairsClimbed7Day)
            }
        }
        // Process the chartEntries as needed (e.g., create a bar chart)
        print("Stairs Climbed Entries: \(chartStairsClimbed7Day)")
    }
    
    

    //MARK: Last 30 Day Data
    func requestAuthorization30Day(comp: @escaping ([BarChartDataEntry])-> Void) {
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                self.queryStairsClimbed30Day{
                    data in
                    comp(data)
                }
            } else {
                print("HealthKit authorization failed. Error: \(String(describing: error))")
            }
        }
    }

    func queryStairsClimbed30Day(comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType ,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { query, statisticsCollection, error in
            guard let statisticsCollection = statisticsCollection else {
                print("Error querying walking + running distance: \(String(describing: error))")
                return
            }

            self.processStatisticsCollection30Day(statisticsCollection){
                data in
                comp(data)
            }
        }

        healthStore.execute(query)
    }

    func processStatisticsCollection30Day(_ statisticsCollection: HKStatisticsCollection,comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: -30, to: now)!
        statisticsCollection.enumerateStatistics(from: endDate, to: now) { statistics, _ in
            if let sum = statistics.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                let date = statistics.startDate
                self.last30DayTotal = self.last30DayTotal! + Int(stepCount)
                let entry = BarChartDataEntry(x: date.timeIntervalSince1970 / 10000 , y: Double(Int(stepCount)))
                self.chartStairsClimbed30Day.append(entry)
                comp( self.chartStairsClimbed30Day)
            }
        }

        // Process the chartEntries as needed (e.g., create a bar chart)
        print("Stairs Climbed Entries: \(chartStairsClimbed30Day)")
    }
    
   
    //MARK: Last 6M Data
    func requestAuthorization6M(comp: @escaping ([BarChartDataEntry])-> Void) {
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                self.queryStairsClimbed6M{
                    data in
                    comp(data)
                }
            } else {
                print("HealthKit authorization failed. Error: \(String(describing: error))")
            }
        }
    }

    func queryStairsClimbed6M(comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -180, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType ,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 30))

        query.initialResultsHandler = { query, statisticsCollection, error in
            guard let statisticsCollection = statisticsCollection else {
                print("Error querying Stairs Climbed: \(String(describing: error))")
                return
            }

            self.processStatisticsCollection6M(statisticsCollection){
                data in
                comp(data)
            }
        }

        healthStore.execute(query)
    }

    func processStatisticsCollection6M(_ statisticsCollection: HKStatisticsCollection,comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: -180, to: now)!
        statisticsCollection.enumerateStatistics(from: endDate, to: now) { statistics, _ in
            if let sum = statistics.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                let date = statistics.startDate
                self.last6MTotal = self.last6MTotal! + Int(stepCount)
                let entry = BarChartDataEntry(x: date.timeIntervalSince1970 / 1000000 , y: Double(Int(stepCount)))
                self.chartStairsClimbed6M.append(entry)
                comp( self.chartStairsClimbed6M)
            }
        }

        // Process the chartEntries as needed (e.g., create a bar chart)
        print("Stairs Climbed Entries: \(chartStairsClimbed6M)")
    }
    
    

    //MARK: Last 1Y Data
    
    func requestAuthorization1Y(comp: @escaping ([BarChartDataEntry])-> Void) {
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                self.queryWStairsClimbed1Y{
                    data in
                    comp(data)
                }
            } else {
                print("HealthKit authorization failed. Error: \(String(describing: error))")
            }
        }
    }

    func queryWStairsClimbed1Y(comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -360, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictEndDate)
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!

        let query = HKStatisticsCollectionQuery(quantityType: stepCountType ,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 30))

        query.initialResultsHandler = { query, statisticsCollection, error in
            guard let statisticsCollection = statisticsCollection else {
                print("Error querying Stairs Climbed: \(String(describing: error))")
                return
            }

            self.processStatisticsCollection1Y(statisticsCollection){
                data in
                comp(data)
            }
        }

        healthStore.execute(query)
    }

    func processStatisticsCollection1Y(_ statisticsCollection: HKStatisticsCollection,comp: @escaping ([BarChartDataEntry])-> Void) {
        let now = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: -360, to: now)!
        statisticsCollection.enumerateStatistics(from: endDate, to: now) { statistics, _ in
            if let sum = statistics.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                let date = statistics.startDate
                self.last1YTotal = self.last1YTotal! + Int(stepCount)
                let entry = BarChartDataEntry(x: date.timeIntervalSince1970 / 1000000 , y: Double(Int(stepCount)))
                self.chartStairsClimbed1Y.append(entry)
                comp( self.chartStairsClimbed1Y)
            }
        }

        // Process the chartEntries as needed (e.g., create a bar chart)
        print("Stairs Climbed Entries: \(chartStairsClimbed1Y)")
    }
    
    
    
}

*/

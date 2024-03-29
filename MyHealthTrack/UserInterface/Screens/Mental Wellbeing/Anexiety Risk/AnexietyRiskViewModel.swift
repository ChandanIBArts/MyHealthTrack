import Foundation
import HealthKit
import DGCharts
import Charts

class DetailsAnexietyRiskHealthKitManager{
    
    
    let healthStore = HKHealthStore()
        
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        // Request authorization to access Apple Stand Hour data
        let typesToRead: Set<HKSampleType> = [
            HKSampleType.categoryType(forIdentifier: .appleStandHour)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            completion(success, error)
        }
    }
        
    func fetchAppleStandHourData(for timeRange: TimeRange, completion: @escaping ([(Date, Double)]?, Error?) -> Void) {
        guard let appleStandHourType = HKObjectType.categoryType(forIdentifier: .appleStandHour) else {
            completion(nil, NSError(domain: "HealthTrackManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Anxiety Risk data not available"]))
            return
        }
        
        // Calculate start and end dates based on the selected time range
        var startDate: Date
        var endDate: Date
        
        switch timeRange {
        case .daily:
            startDate = Calendar.current.startOfDay(for: Date())
            endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        case .weekly:
            startDate = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            endDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDate)!
        case .monthly:
            startDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
            endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        case .halfYearly:
            let currentMonth = Calendar.current.component(.month, from: Date())
            startDate = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date()), month: currentMonth < 7 ? 1 : 7, day: 1))!
            endDate = Calendar.current.date(byAdding: .month, value: currentMonth < 7 ? 6 : 12 - currentMonth, to: startDate)!
        case .yearly:
            startDate = Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Date()))!
            endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: appleStandHourType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion(nil, error)
                return
            }
            
            var appleStandHourData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueAppleStandHour.stood.rawValue ? 1.0 : 0.0
                appleStandHourData.append((date, value))
            }
            
            completion(appleStandHourData, nil)
        }
        
        healthStore.execute(query)
    }
    }

    // Enum to represent different time ranges
    enum TimeRange {
        case daily
        case weekly
        case monthly
        case halfYearly
        case yearly
    }
    
    

    
    /*
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
    */




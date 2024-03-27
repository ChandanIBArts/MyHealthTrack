import Foundation
import HealthKit

class SleepHealthKitManager {
    
    let healthStore = HKHealthStore()
    
    func requestAuthorization(for types: Set<HKSampleType>, completion: @escaping (Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: nil, read: types) { (success, error) in
            completion(success, error)
        }
    }
    
    //MARK: Daily Data
    func fetchDailySleepData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .day, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var sleepData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                sleepData.append((date, value))
            }
            
            completion(sleepData)
        }
        
        healthStore.execute(query)
    }
    
    
    
    //MARK: Weekly Data
    func fetchWeeklySleepData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .weekOfMonth, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var sleepData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                sleepData.append((date, value))
            }
            
            completion(sleepData)
        }
        
        healthStore.execute(query)
    }
    
    
    //MARK: Monthly Data
    func fetchMonthlySleepData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .month, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var sleepData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                sleepData.append((date, value))
            }
            
            completion(sleepData)
        }
        
        healthStore.execute(query)
    }
    
    
    //MARK: halfYearly Data
    func fetchHalfYearlySleepData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .month, value: -6, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var sleepData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                sleepData.append((date, value))
            }
            
            completion(sleepData)
        }
        
        healthStore.execute(query)
    }
    
}

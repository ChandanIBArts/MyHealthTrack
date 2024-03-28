import Foundation
import HealthKit

class HeartRateHealthKitManager {
    
    let healthStore = HKHealthStore()
    
    func requestAuthorization(for types: Set<HKSampleType>,completion: @escaping (Bool, Error?) -> Void) {
//        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
        healthStore.requestAuthorization(toShare: nil, read: types) { (success, error) in
            completion(success, error)
        }
    }
    
    //MARK: Per Hours Data
    func fetchHoursHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .hour, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Daily Data
    func fetchDailyHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
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
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Weekly Data
    func fetchWeeklyHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .weekOfYear, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Monthly Data
    func fetchMonthlyHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
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
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Half-Yearly Data
    func fetchHalfYearlyHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
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
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Yearly Data
    func fetchYearlyHeartRateData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion([])
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else {
            completion([])
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            guard let result = result, let averageQuantity = result.averageQuantity() else {
                completion([])
                return
            }
            
            let averageHeartRate = averageQuantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            let data = [(now, averageHeartRate)]
            completion(data)
        }
        
        healthStore.execute(query)
    }
}

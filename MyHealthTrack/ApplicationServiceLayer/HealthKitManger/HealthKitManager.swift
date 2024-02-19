
import Foundation
import HealthKit

// MARK: - extension for public methods -

typealias HealthKitDataBlock = (_ sample: SampleData?)->()

extension HealthKitManager {
    
    func requestAuthorization(_ completion:@escaping(_ success: Bool)->()) {
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                print("Permissions granted successfully")
            } else {
                print("\(error?.localizedDescription ?? "Request to fetch the data failed.")")
            }
            completion(success)
        }
    }
    
    func fetchStepData(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .stepCount, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
    
    func fetchCaloriesBurned(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .caloriesBurned, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
    
    func fetchStandTime(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .stand, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }

    func fetchExerciseDuration(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .exerciseDuration, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
    
    func fetchHeartRate(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .heartRate, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }

    func fetchRestingHeartRate(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .heartRateResting, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
    
    func fetchWalkingHeartRate(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .heartRateResting, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
    
    func fetchHeartRateVariability(startDate: Date? = nil, endDate: Date? = nil, completion: @escaping HealthKitDataBlock) {
        
        fetchHealthData(healtItem: .heartRateResting, startDate: startDate, endDate: endDate) { stepCount in
            completion(stepCount)
        }
    }
}

public class HealthKitManager {
    
    static let `default` = HealthKitManager()
    
    private let healthStore = HKHealthStore()
    private let typesToRead = {
        let listItems = HealthItem.allCases.map{$0.sampleType}
        let set = Set(listItems)
        return set
    }()
    
    private init() { }
    
}

//MARK: - Extension for prvate methods -
private extension HealthKitManager {
    
    private func fetchHealthData(healtItem: HealthItem, startDate: Date? = nil, endDate: Date? = nil, completion: @escaping (_ data: SampleData)->())  {
        
        print("Fetching data for \(healtItem.sampleName)")
        let today = Date()
        let sDate = startDate ?? Calendar.current.startOfDay(for: today)
        let eDate = endDate ?? Calendar.current.date(byAdding: .day, value: 1, to: sDate)!
        let predicate = HKQuery.predicateForSamples(withStart: sDate, end: eDate, options: [])
        
        let query = HKSampleQuery(sampleType: healtItem.sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKQuantitySample] else {
                print("Error in fetchin \(healtItem.sampleName)")
                return
            }
            var total: Double = 0
            for sample in samples {
                total += sample.quantity.doubleValue(for: healtItem.unitType)
            }
            
            print("Total \(healtItem.sampleName): \(total)")
            
            let sampleData = SampleData(value: Int(total), type: healtItem, time: samples.last?.endDate)
            completion(sampleData)
        }

        healthStore.execute(query)
    }
}





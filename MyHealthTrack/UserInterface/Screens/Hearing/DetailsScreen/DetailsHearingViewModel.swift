//
//  DetailsHearingViewModel.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 27/03/24.
//

import Foundation
import HealthKit

class HearingHealthKitManager {
    
    let healthStore = HKHealthStore()
    
    func requestAuthorization(for types: Set<HKSampleType>, completion: @escaping (Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: nil, read: types) { (success, error) in
            completion(success, error)
        }
    }
    
    //MARK: Daily Data
    func fetchDailyHearingData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let hearingType = HKObjectType.categoryType(forIdentifier: .audioExposureEvent) else {
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
        
        let query = HKSampleQuery(sampleType: hearingType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var hearingData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                hearingData.append((date, value))
            }
            
            completion(hearingData)
        }
        
        healthStore.execute(query)
    }
    
    

    //MARK: Weekly Data
    func fetchWeeklyHearingData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let hearingType = HKObjectType.categoryType(forIdentifier: .audioExposureEvent) else {
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
        
        let query = HKSampleQuery(sampleType: hearingType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var hearingData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                hearingData.append((date, value))
            }
            
            completion(hearingData)
        }
        
        healthStore.execute(query)
    }
    
    
    //MARK: Monthly Data
    func fetchMonthlyHearingData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let hearingType = HKObjectType.categoryType(forIdentifier: .audioExposureEvent) else {
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
        
        let query = HKSampleQuery(sampleType: hearingType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var hearingData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                hearingData.append((date, value))
            }
            
            completion(hearingData)
        }
        
        healthStore.execute(query)
    }
    
    
    
    //MARK: halfYearly Data
    func fetchHalfYearlyHearingData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let hearingType = HKObjectType.categoryType(forIdentifier: .audioExposureEvent) else {
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
        
        let query = HKSampleQuery(sampleType: hearingType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var hearingData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                hearingData.append((date, value))
            }
            
            completion(hearingData)
        }
        
        healthStore.execute(query)
    }
    
    
    //MARK: Yearly Data
    func fetchYearlyHearingData(completion: @escaping ([(Date, Double)]) -> Void) {
        guard let hearingType = HKObjectType.categoryType(forIdentifier: .audioExposureEvent) else {
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
        
        let query = HKSampleQuery(sampleType: hearingType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion([])
                return
            }
            
            var hearingData: [(Date, Double)] = []
            
            for sample in samples {
                let date = sample.startDate
                let value = sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue ? sample.endDate.timeIntervalSince(sample.startDate) / 60.0 : 0
                print(value)
                hearingData.append((date, value))
            }
            
            completion(hearingData)
        }
        
        healthStore.execute(query)
    }
    
}

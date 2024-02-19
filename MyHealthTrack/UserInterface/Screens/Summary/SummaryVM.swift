

import Foundation

class SummaryVM {
 
    private(set) var summaryData: SummaryData?
    
    var willFetchData: CompletionBlock?
    var dataFetched: CompletionBlock?
    
    private var fetchingInProgress = false
    
    private var message: String?
    private let dispatchGorup = DispatchGroup()

    func fetchSumaryData() {
        
        guard !fetchingInProgress else {
            print("Already fetching data...return")
            return
        }
        
        print("Data fetch started...")
        fetchingInProgress = true
        willFetchData?()
        
        var stepCount: SampleData?
        var caloriesBurn: SampleData?
        var exerciseDuration: SampleData?
        var standDuration: SampleData?
        var heartRate: SampleData?
        var heartRateResting: SampleData?
        var walkingHeartRate: SampleData?
        var heartRateVariability: SampleData?
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchStepData { steps in
            stepCount = steps
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchStandTime { stand in
            standDuration = stand
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchCaloriesBurned { calories in
            caloriesBurn = calories
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchHeartRate{ bpm in
            heartRate = bpm
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchRestingHeartRate{ restimgBPM in
            heartRateResting = restimgBPM
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchExerciseDuration { duration in
            exerciseDuration = duration
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchWalkingHeartRate { heartRate in
            walkingHeartRate = heartRate
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.enter()
        HealthKitManager.default.fetchHeartRateVariability { variability in
            heartRateVariability = variability
            self.dispatchGorup.leave()
        }
        
        dispatchGorup.notify(queue: .main) { [weak self] in
            
            guard let self = self else { return }
            
            self.summaryData = SummaryData(stepCount: stepCount, caloriesBurn: caloriesBurn, exerciseDuration: exerciseDuration, standDuration: standDuration, heartRate: heartRate, heartRateResting: heartRateResting, walkingHeartRate: walkingHeartRate, heartRateVariablity: heartRateVariability)
            
            self.fetchingInProgress = false
            self.dataFetched?()
        }
    }
}

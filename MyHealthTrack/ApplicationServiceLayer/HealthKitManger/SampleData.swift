
import Foundation
import HealthKit

struct SampleData {
    
    var value: Int
    var type: HealthItem
    var time: Date?
    
    var timeString: String? {
        let formater = DateFormatter()
        guard let time = self.time else { return nil }
        formater.timeStyle = .short
        return formater.string(from: time)
    }
}

//MARK: - Health Item enum -

enum HealthItem: CaseIterable {
    
    case stepCount
    case caloriesBurned
    case exerciseDuration
    case stand
    case heartRate
    case heartRateResting
    case walkingHeartRate
    case heartRateVariability
    
    var unitType: HKUnit {
        switch self {
        case .stepCount: return HKUnit.count()
        case .exerciseDuration: return HKUnit.minute()
        case .heartRateVariability, .heartRateResting,
                .walkingHeartRate, .heartRate: return HKUnit.count().unitDivided(by: HKUnit.minute())
        case .caloriesBurned:
            return HKUnit.largeCalorie()
        case .stand:
            return HKUnit.hour()
        }
    }
    
    var sampleName: String {
        switch self {
        case .stepCount: return "Step Count"
        case .caloriesBurned: return "Calories Burned"
        case .exerciseDuration: return "Exercise Duration"
        case .stand: return "Stand Duration"
        case .heartRate: return "Resting heart rate"
        case .heartRateResting: return "heart rate"
        case .walkingHeartRate: return "Walking Heart Rate"
        case .heartRateVariability: return "Heart Rate Variability"
        }
    }
    
    var sampleType: HKQuantityType {
        switch self {
        case .stepCount:
            return HKObjectType.quantityType(forIdentifier: .stepCount)!
        case .caloriesBurned:
            return HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        case .exerciseDuration:
            return HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        case .stand:
            return HKObjectType.quantityType(forIdentifier: .appleStandTime)!
        case .heartRate:
            return HKObjectType.quantityType(forIdentifier: .restingHeartRate)!
        case .heartRateResting:
            return HKObjectType.quantityType(forIdentifier: .heartRate)!
        case .walkingHeartRate: return HKObjectType.quantityType(forIdentifier: .walkingHeartRateAverage)!
        case .heartRateVariability: return HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        }
    }
}

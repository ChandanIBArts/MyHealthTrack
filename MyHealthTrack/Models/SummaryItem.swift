
import Foundation
import UIKit

enum SummaryItem: Int, CaseIterable {
    
    case step = 0, heartRate, restingHeartRate, workout, walkingHeartRate, heartRateVariability
    
    var itemImage: UIImage {
        switch self {
        case .step: return #imageLiteral(resourceName: "Steps")
        case .heartRate,
            .restingHeartRate,
            .walkingHeartRate,
            .heartRateVariability: return #imageLiteral(resourceName: "Heart")
        case .workout: return #imageLiteral(resourceName: "Activity-and-Workouts")
        }
    }
    
    var itemTitle: String {
        switch self {
        case .step: return "Steps"
        case .heartRate: return "Heart Rate"
        case .restingHeartRate: return "Resting Heart Rate"
        case .workout: return "Workouts"
        case .walkingHeartRate: return "Walking Heart Rate"
        case .heartRateVariability: return "Heart Rate Variablitity"
        }
    }
    
    var itemTitleColor: UIColor {
        switch self {
        case .step: return .systemGreen
        case .heartRate, .restingHeartRate, .walkingHeartRate, .heartRateVariability: return .systemPink
        case .workout: return .projectGreen
        }
    }
    
    var itemUnit: String {
        switch self {
        case .step: return "steps"
        case .heartRate, .restingHeartRate, .walkingHeartRate: return "BPM"
        case .heartRateVariability: return "ms"
        case .workout: return "min"
        }
    }
}


import Foundation
import UIKit

enum HealthCategory: CaseIterable {
    case activity
    
    var title: String {
        switch self {
        case .activity: return "Activity"
        }
    }
    
    var image: UIImage {
        switch self {
        case .activity:  return #imageLiteral(resourceName: "Activity-and-Workouts")
        }
    }
}


import Foundation
import CoreVideo

extension APIManager {
    
    enum EndPoints: String {
        case getEmailCode
        case register
        case login
        case logout = "userLogout"
        case getProfile
        case updateProfile

        case baseURL = "http://mht.demospace.cloud/api/"
        
        var urlString: String {
            switch self {
            
            case .baseURL: return self.rawValue
                
            default: return "\(EndPoints.baseURL.urlString)\(self.rawValue)"
                
            }
        }
    }
}


import Foundation

struct GetProfileResponse: Response {
    var success: Int
    var message: String
    
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case user = "record"
    }
}

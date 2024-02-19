
import Foundation

struct EditProfileResponse: Response {
    var success: Int
    var message: String
    
    var record: Record
   
}

struct Record: Manageable {
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case user = "data"
    }
}

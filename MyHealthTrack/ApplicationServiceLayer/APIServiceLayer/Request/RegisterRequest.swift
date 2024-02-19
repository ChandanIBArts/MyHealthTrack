

import Foundation
import WatchConnectivity

struct RegisterRequest: Request, Manageable {
    
    typealias ResponseType = RegisterResponse
    var path: String = APIManager.EndPoints.register.urlString
    var method: RequestMethod { .POST }

    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let gender: String = ""
    let profileImage: String = ""
    
    var body: [String : Any] {
        guard let dict = try? self.toDictionary() else { return [:] }
        return dict
    }
    
    enum CodingKeys: String, CodingKey  {
        case firstName = "fname", lastName = "lname", email, phone = "mobile_number", profileImage = "profile_image"
    }
}



import Foundation

struct EditProfileRequest: Request, Manageable {
    
    typealias ResponseType = EditProfileResponse
    var path: String = APIManager.EndPoints.updateProfile.urlString
    var method: RequestMethod { .POST }

    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let gender: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey  {
        case firstName = "fname", lastName = "lname", email, phone = "mobile_number", gender, profileImage = "profile_image"
    }
    
    var body: [String : Any] {
        guard let dict = try? self.toDictionary() else { return [:] }
        return dict
    }
    
    var headers: [String: String]? {
        if let token = UserDefaultManager.token {
            return ["Authorization": "Bearer \(token)"]
        } else {
            return nil
        }
    }
}

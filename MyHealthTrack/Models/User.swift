
import Foundation

struct User: Manageable {
    
    static var sharedUser: User? {
        get {
            guard let jsonDict = UserDefaultManager.userInfoDict else { return nil }
            let user = User.getObject(dictionary: jsonDict)
            return user
        } set {
            let jsonDict = try? newValue?.toDictionary()
            UserDefaultManager.userInfoDict = jsonDict
        }
    }
    
    var userId: Int!

    var firstName: String = ""
    
    var lastName: String = ""
    
    var email: String = ""
    
    var phone: String = ""
    
    var gender: Gender?
    
    var profileImage: String?
    
    var token: String? {
        get {
            UserDefaultManager.token
        } set {
            UserDefaultManager.token = newValue
        }
    }
    
    static func logout() {
        UserDefaultManager.token = nil
        User.sharedUser = nil
    }

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "fname"
        case lastName = "lname"
        case email = "email"
        case phone = "mobile_number"
        case gender = "gender"
        case profileImage = "profile_image"
    }
}

extension User {
    
    enum Gender: String, Manageable, CaseIterable {
        
        case select = "Select", male = "Male", female = "Female", other = "Other"
    
    }
}



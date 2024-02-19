
import Foundation

struct OTPRequest: Request, Manageable {
    
    typealias ResponseType = OTPResponse
    
    let otp: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case email, otp = "email_code"
    }
    
    var method: RequestMethod = .POST

    var path: String = APIManager.EndPoints.login.urlString

    var body: [String : Any] {
        guard let dict = try? self.toDictionary() else { return [:] }
        return dict
    }
}

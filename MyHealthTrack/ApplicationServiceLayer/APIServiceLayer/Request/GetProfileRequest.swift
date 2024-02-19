
import Foundation

struct GetProfileRequest: Request {
    
    typealias ResponseType = GetProfileResponse
    
    var method: RequestMethod = .GET
    var path: String = APIManager.EndPoints.getProfile.urlString

    var body: [String : Any] = [:]
    
    var headers: [String: String]? {
        if let token = UserDefaultManager.token {
            return ["Authorization": "Bearer \(token)"]
        } else {
            return nil
        }
    }
    
}

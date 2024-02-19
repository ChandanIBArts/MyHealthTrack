
import Foundation

struct LogoutRequest: Request {
    
    typealias ResponseType = LogoutResponse
    
    var method: RequestMethod = .GET
    var path: String = APIManager.EndPoints.logout.urlString

    var body: [String : Any] = [:]
    
    var headers: [String: String]? {
        if let token = UserDefaultManager.token {
            return ["Authorization": "Bearer \(token)"]
        } else {
            return nil
        }
    }
}

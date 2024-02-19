

import Foundation

struct LoginRequest: Request, Manageable {
      
    typealias ResponseType = LoginResponse
    var path: String = APIManager.EndPoints.getEmailCode.urlString
    let email: String
    
        
    enum CodingKeys: CodingKey {
        case email
    }

    var method: RequestMethod { .POST }
    
    var body: [String : Any] {
        guard let dict = try? self.toDictionary() else { return [:] }
        return dict
    }
}

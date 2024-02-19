

import Foundation

struct OTPResponse: Response {
    var success: Int
    var message: String
    
    var token: String?
}

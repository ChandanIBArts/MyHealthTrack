
import Foundation

protocol Response: Manageable {
    var success: Int { get set }
    var message: String { get set }
}

extension Response {
    var isSuccess: Bool {
        success == 1
    }
}

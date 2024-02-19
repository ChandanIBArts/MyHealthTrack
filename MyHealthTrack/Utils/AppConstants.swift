
import Foundation


typealias CompletionBlock = (()->())
typealias CompletionBlockResponse = ((_ message: String? )->())
typealias ValidationBlock = ((_ message: String?,
                              _ validationType: ValidationTest.ValidationType)->())

struct Constants {
    static let otpLength = 6
}


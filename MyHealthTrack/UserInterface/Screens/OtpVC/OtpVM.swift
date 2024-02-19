
import Foundation

class OtpVM {
    
    var willSubmit: CompletionBlock?
    var otpVerificationSuccessful: CompletionBlockResponse?
    var otpVerificationFailed: CompletionBlockResponse?
    var validationFailed: ValidationBlock?

    var email: String!
    
    func varifyOTP(_ otp: String, email: String) {
        
        let validation = ValidationTest.checkOTP(otp)
        
        validation.success ? callOTPVerificationAPI(otp: otp, email: email) : validationFailed?(validation.message, .email)
    }
    
    private func callOTPVerificationAPI(otp: String, email: String) {
        self.willSubmit?()
        
        Task {
            let result = await APIManager.shared.callOTPVerificationAPI(otp: otp, email: email)
            switch result {
           
            case .success(let otpResponse):
                if otpResponse.isSuccess {
                    UserDefaultManager.token = otpResponse.token ?? ""
                    let result = await APIManager.shared.callGetProfileAPI()
                    handleResults(otpResponse: otpResponse, getProfileResult: result)
                } else {
                    otpVerificationFailed?(otpResponse.message)
                }
            
            case .failure(let networkError):
                otpVerificationFailed?(networkError.localizedDescription)
            }
        }
    }
    
    private func handleResults(
        otpResponse: OTPResponse,
        getProfileResult: Result<GetProfileResponse, NetworkRequestError>) {
        
        switch getProfileResult {
        case .success(let getProfileResponse):
            if getProfileResponse.isSuccess {
                User.sharedUser = getProfileResponse.user
                otpVerificationSuccessful?(otpResponse.message)
            } else {
                otpVerificationFailed?(otpResponse.message)
            }

        case .failure(let networkError):
            otpVerificationFailed?(networkError.localizedDescription)
        }
    }
}


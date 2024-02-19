
import Foundation

class RegisterVM {
    
    var willRegister: CompletionBlock?
    var registerSuccessful: CompletionBlockResponse?
    var registerFailed: CompletionBlockResponse?
    var validationFailed: ValidationBlock?

    func registerWith(firstName: String,
                      lastName: String,
                      email: String, code: String) {
       
        let validation = ValidationTest.checkRegisterValidations(firstName: firstName, lastName: lastName, email: email, phone: code)
        
        validation.success ? callRegisterAPI(firstName: firstName, lastName: lastName, email: email, otp: code) : validationFailed?(validation.message, .email)
    }
    
    private func callRegisterAPI(firstName: String,
                                 lastName: String,
                                 email: String, otp: String) {
        self.willRegister?()
        
        Task {
            
            let result = await APIManager.shared.callRegisterAPI(firstName: firstName, lastName: lastName, email: email,                          phone: otp)
            
            switch result {
            
            case .success(let registerResponse):
                if registerResponse.isSuccess {
                    let otpResult = await APIManager.shared.callLoginAPI(email: email)
                    self.handleResults(registerResponse: registerResponse, OTPResult: otpResult)
                } else {
                    registerFailed?(registerResponse.message)
                }
            
            case .failure(let networkError):
                registerFailed?(networkError.localizedDescription)
            }
        }
    }
    
    private func handleResults(
        registerResponse: RegisterResponse,
        OTPResult: Result<LoginResponse, NetworkRequestError>) {
        
        switch OTPResult {
        case .success(let otpResponse):
            otpResponse.isSuccess ? registerSuccessful?(registerResponse.message +  otpResponse.message) : registerFailed?(otpResponse.message)

        case .failure(let networkError):
            registerFailed?(networkError.localizedDescription)
        }
    }
}

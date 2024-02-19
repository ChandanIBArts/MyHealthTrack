
import Foundation

class LoginVM {
    
    var willLogin: CompletionBlock?
    var loginSuccessful: CompletionBlockResponse?
    var loginFailed: CompletionBlockResponse?
    var validationFailed: ValidationBlock?

    func loginWith(email: String) {
        
        let validation = ValidationTest.checkLoginValidations(email: email)
        
        validation.success ? callLoginAPI(email: email) : validationFailed?(validation.message, .email)
    }
    
    private func callLoginAPI(email: String) {
        self.willLogin?()
        
        Task {
            
            let result = await APIManager.shared.callLoginAPI(email: email)
            
            switch result {
           
            case .success(let loginResponse):
                loginResponse.isSuccess ? loginSuccessful?(loginResponse.message) : loginFailed?(loginResponse.message)
            
            case .failure(let networkError):
                loginFailed?(networkError.localizedDescription)
            }
        }
    }
}


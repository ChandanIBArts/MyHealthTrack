
import Foundation

typealias Validation = (success: Bool, message: String?)

class ValidationTest {
    
    static func checkLoginValidations(email: String) -> Validation {
        
        guard !email.isBlank else {
            return (success: false, message: ValidationMessages.emailEmpty)
        }
        
        guard email.isValidEmail else {
            return (success: false, message: ValidationMessages.emailInvalid)
        }
        
        return (true, nil)
    }
    
    static func checkRegisterValidations(
        firstName: String,
        lastName: String,
        email: String, phone: String) -> Validation {
        
        guard !firstName.isBlank else {
            return (success: false, message: ValidationMessages.firstNameEmpty)
        }
        
        guard !lastName.isBlank else {
            return (success: false, message: ValidationMessages.lastNameEmpty)
        }
        
        guard !email.isBlank else {
            return (success: false, message: ValidationMessages.emailEmpty)
        }
        
        guard email.isValidEmail else {
            return (success: false, message: ValidationMessages.emailInvalid)
        }
            
        guard !phone.isBlank else {
            return (success: false, message: ValidationMessages.phoneEmpty)
        }

        guard phone.isValidPhone else {
            return (success: false, message: ValidationMessages.phoneInvalid)
        }
        
        return (true, nil)

    }
    
    static func checkOTP(_ otp: String)-> Validation {
        guard !otp.isBlank else {
            return (success: false, message: ValidationMessages.otpEmpty)
        }

        guard otp.count == Constants.otpLength else {
            return (success: false, message: ValidationMessages.otpInvalid)
        }
        
        return (true, nil)
    }
}

extension ValidationTest {
    
    enum ValidationMessages {
        static let firstNameEmpty = "Please enter first name."
        static let lastNameEmpty = "Please enter last name."
        static let emailEmpty = "Please enter email."
        static let emailInvalid = "Invalid Email address."
        static let phoneEmpty = "Please enter phone number."
        static let phoneInvalid = "Invalid hhone numner"

        static let otpEmpty = "Please enter OTP Code received on email."
        static let otpInvalid = "Invalid OTP"
    }
    
    enum ValidationType {
        case firstName, lastName, email, emailCode
    }
}



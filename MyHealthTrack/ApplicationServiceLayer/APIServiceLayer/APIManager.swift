
import Foundation
import Combine

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
}

//Async Await Extension
extension APIManager {
    
    func callLoginAPI(email: String) async -> Result<LoginResponse, NetworkRequestError> {
        
        let loginRequest = LoginRequest(email: email)
        let result = await NetworkManager.shared.dispatch(loginRequest)
        return result
    }
    
    func callRegisterAPI(firstName: String,
                         lastName: String,
                         email: String,
                         phone: String) async -> Result<RegisterResponse, NetworkRequestError> {
        let loginRequest = RegisterRequest(firstName: firstName, lastName: lastName, email: email, phone: phone)
        let result = await NetworkManager.shared.dispatch(loginRequest)
        return result
    }
    
    func callGetProfileAPI() async -> Result<GetProfileResponse, NetworkRequestError> {
        let otpRequest = GetProfileRequest()
        let result = await NetworkManager.shared.dispatch(otpRequest)
        return result
    }
    
    func callOTPVerificationAPI(otp: String, email: String) async -> Result<OTPResponse, NetworkRequestError> {
        let otpRequest = OTPRequest(otp: otp, email: email)
        let result = await NetworkManager.shared.dispatch(otpRequest)
        return result
    }
    
    func callEditProfileAPI(firstName: String,
                            lastName: String,
                            email: String,
                            phone: String,
                            gender: String?,
                            profileImage: String?) async -> Result<EditProfileResponse, NetworkRequestError> {
        let editProfileRequest = EditProfileRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            gender: gender,
            profileImage: profileImage)
        let result = await NetworkManager.shared.dispatch(editProfileRequest)
        return result
    }

    func callLogoutAPI() async -> Result<LogoutResponse, NetworkRequestError> {
        let result = await NetworkManager.shared.dispatch(LogoutRequest())
        return result
    }
}

//API Manager with Callback block
extension APIManager {
    
    private func callAPIWithEndpoint(_ endPoint: EndPoints, callBack: @escaping NetworkCallBack) {
        NetworkManager.shared.callAPI(url: endPoint.urlString, method: .GET, requestType: .raw) { response, error in
            callBack(response, error)
        }
    }
}


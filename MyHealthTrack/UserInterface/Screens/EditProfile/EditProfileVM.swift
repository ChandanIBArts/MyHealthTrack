
import Foundation

class EditProfileVM {
    
    var willEditProfile: CompletionBlock?
    var editProfileSuccessful: CompletionBlockResponse?
    var editProfileFailed: CompletionBlockResponse?
    var validationFailed: ValidationBlock?

    var willLogout: CompletionBlock?
    var logoutSuccessful: CompletionBlock?
    
    func editProfileWith(firstName: String,
                      lastName: String,
                         email: String, phone: String, gender: User.Gender?, profileImage: String?) {
       
        let validation = ValidationTest.checkRegisterValidations(firstName: firstName, lastName: lastName, email: email, phone: phone)
        
        validation.success ? callEditProfileAPI(firstName: firstName, lastName: lastName, email: email, phone: phone, gender: gender, profileImage: profileImage) : validationFailed?(validation.message, .email)
    }
    
    func logout() {
        callLogoutAPI()
    }
}

extension EditProfileVM {
    
    private func callLogoutAPI() {
        self.willLogout?()
        Task {
            
            let result = await APIManager.shared.callLogoutAPI()
            User.logout()
            NotificationManager.shared.sendLogoutNotification()

            logoutSuccessful?()
        }
    }

    private func callEditProfileAPI(firstName: String,
                                 lastName: String,
                                    email: String, phone: String, gender: User.Gender?, profileImage: String?) {
        self.willEditProfile?()
        
        Task {
            
            let result = await APIManager.shared.callEditProfileAPI(firstName: firstName, lastName: lastName, email: email, phone: phone, gender: gender?.rawValue ?? "", profileImage: profileImage)
            
            switch result {
            
            case .success(let updateProfileResponse):
                if updateProfileResponse.isSuccess {
                    User.sharedUser = updateProfileResponse.record.user
                    editProfileSuccessful?(updateProfileResponse.message)
                } else {
                    editProfileFailed?(updateProfileResponse.message)
                }
            
            case .failure(let networkError):
                editProfileFailed?(networkError.localizedDescription)
            }
        }
    }
}

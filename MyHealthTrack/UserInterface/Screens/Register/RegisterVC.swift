
import UIKit

class RegisterVC: BaseViewController {

    @IBOutlet private weak var txtfieldFirstName: AppTextField!
    @IBOutlet private weak var txtfieldLastName: AppTextField!
    @IBOutlet private weak var txtfieldEmail: AppTextField!
    @IBOutlet private weak var txtfieldOTP: AppTextField!
    @IBOutlet private weak var scrollView: UIScrollView!

    private let viewModel = RegisterVM()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        
        viewModel.validationFailed = { [weak self] message, validationType in
            guard let self = self else { return }
            self.showCancelAlert(message: message)
        }
        
        viewModel.willRegister = {
            AppLoader.shared.loader(true)
        }
        
        viewModel.registerSuccessful = {[weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            runOnMainThread { CoordinatorManager.shared.mainCoordinator?.gotoOTP(email: self.txtfieldEmail.text ?? "") }
        }
           
        viewModel.registerFailed = {[weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            self.showCancelAlert(message: message)
        }
    }
    
    @IBAction private func registerTap(_ sender: UIButton) {
       register()
    }
    
    private func register() {
        viewModel.registerWith(
            firstName: txtfieldFirstName.text ?? "",
            lastName: txtfieldLastName.text ?? "",
            email: txtfieldEmail.text ?? "",
            code: txtfieldOTP.text ?? "")
    }
}


extension RegisterVC {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtfieldOTP {
            return !(textField.text?.count ?? 0 >= 10) || string.count == 0
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nextResponder: UITextField?
        if textField == txtfieldFirstName {
            nextResponder = txtfieldLastName
        } else if textField == txtfieldLastName {
            nextResponder = txtfieldEmail
        } else if textField == txtfieldEmail {
            nextResponder = txtfieldOTP
        } else if textField == txtfieldOTP {
            register()
            return textField.resignFirstResponder()
        }
        nextResponder?.becomeFirstResponder()
        return false
    }
}

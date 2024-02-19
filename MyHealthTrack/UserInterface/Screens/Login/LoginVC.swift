
import UIKit

class LoginVC: BaseViewController {

    @IBOutlet private weak var txtfieldEmail: AppTextField!
    @IBOutlet private weak var btnLogin: UIButton!
    @IBOutlet private weak var lblRegister: UILabel!

    private let viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblRegister.attributedText = lblRegister.text?.dottedUnderLineString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtfieldEmail.text = nil
    }
    
    @IBAction private func loginTapped(_ sender: UIButton) {
        viewModel.loginWith(email: txtfieldEmail.text ?? "")
    }
    
    @IBAction private func registerTapped(_ sender: UIButton) {
        CoordinatorManager.shared.mainCoordinator?.gotoRegister()
    }
    
    override func bindViewModel() {
        
        viewModel.validationFailed = { [weak self] message, validationType in
            guard let self = self else { return }
            self.showCancelAlert(message: message)
        }
        
        viewModel.willLogin = {
            AppLoader.shared.loader(true)
        }
        
        viewModel.loginSuccessful = {[weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            runOnMainThread {
                CoordinatorManager.shared.mainCoordinator?.gotoOTP(email: self.txtfieldEmail.text ?? "")
            }
        }
           
        viewModel.loginFailed = { [weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            self.showCancelAlert(message: message)
        }
    }
   
}

extension LoginVC {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

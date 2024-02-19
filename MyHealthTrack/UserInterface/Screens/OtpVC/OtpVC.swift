
import UIKit

class OtpVC: BaseViewController {

    @IBOutlet private weak var txtFieldOTP1: AppTextField!
    @IBOutlet private weak var txtFieldOTP2: AppTextField!
    @IBOutlet private weak var txtFieldOTP3: AppTextField!
    @IBOutlet private weak var txtFieldOTP4: AppTextField!
    @IBOutlet private weak var txtFieldOTP5: AppTextField!
    @IBOutlet private weak var txtFieldOTP6: AppTextField!

    private(set) var viewModel = OtpVM()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func submitTapped(_ sender: UIButton) {
        verifyOTP()
    }
    
    override func bindViewModel() {

        viewModel.validationFailed = { [weak self] message, validationType in
            guard let self = self else { return }
            self.showCancelAlert(message: message)
        }
        
        viewModel.willSubmit = {
            AppLoader.shared.loader(true)
        }
        
        viewModel.otpVerificationSuccessful = { message in
            AppLoader.shared.loader(false)
            CoordinatorManager.shared.mainCoordinator?.gotoSummary()
        }
           
        viewModel.otpVerificationFailed = {[weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            self.showCancelAlert(message: message)
        }
    }
    
    private func verifyOTP() {
        let otpString = "\(txtFieldOTP1.text ?? "")\(txtFieldOTP2.text ?? "")\(txtFieldOTP3.text ?? "")\(txtFieldOTP4.text ?? "")\(txtFieldOTP5.text ?? "")\(txtFieldOTP6.text ?? "")"
        
        viewModel.varifyOTP(otpString, email: self.viewModel.email)
    }
}

extension OtpVC {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var nextResponder: UITextField?
        if textField == txtFieldOTP1 {
            nextResponder = txtFieldOTP2
        } else if textField == txtFieldOTP2 {
            nextResponder = txtFieldOTP3
        } else if textField == txtFieldOTP3 {
            nextResponder = txtFieldOTP4
        } else if textField == txtFieldOTP4 {
            nextResponder = txtFieldOTP5
        } else if textField == txtFieldOTP5 {
            nextResponder = txtFieldOTP6
        } else if textField == txtFieldOTP6 {
            verifyOTP()
            return textField.resignFirstResponder()
        }
        nextResponder?.becomeFirstResponder()
        return false
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if (textField.text?.count)! < 1 && string.count > 0 {
            
            if textField == txtFieldOTP1 {
                txtFieldOTP2.becomeFirstResponder()
            }
            
            if textField == txtFieldOTP2 {
                txtFieldOTP3.becomeFirstResponder()
            }
            
            if textField == txtFieldOTP3 {
                txtFieldOTP4.becomeFirstResponder()
            }
            
            if textField == txtFieldOTP4 {
                txtFieldOTP5.becomeFirstResponder()
            }
            
            if textField == txtFieldOTP5 {
                txtFieldOTP6.becomeFirstResponder()
            }
            
            if textField == txtFieldOTP6 {
                textField.resignFirstResponder()
            }
            
            textField.text = string
            return false
            
        }
        
        else if (textField.text?.count)! >= 1 && string.count == 0 {
            
            if textField == txtFieldOTP2 {
                txtFieldOTP1.becomeFirstResponder()
            }
            
            if (textField == txtFieldOTP3) {
                txtFieldOTP2.becomeFirstResponder()
            }
            
            if (textField == txtFieldOTP4) {
                txtFieldOTP3.becomeFirstResponder()
            }
            
            if (textField == txtFieldOTP5) {
                txtFieldOTP4.becomeFirstResponder()
            }
            
            if (textField == txtFieldOTP6) {
                txtFieldOTP5.becomeFirstResponder()
            }
            
            if (textField == txtFieldOTP1) {
                txtFieldOTP1.resignFirstResponder()
            }
            
            textField.text = string
            return false
        }
        
        else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
}

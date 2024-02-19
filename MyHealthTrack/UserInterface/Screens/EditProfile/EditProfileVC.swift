
import UIKit

class EditProfileVC: BaseViewController {

    @IBOutlet private weak var txtfieldFirstName: AppTextField!
    @IBOutlet private weak var txtfieldLastName: AppTextField!
    @IBOutlet private weak var txtfieldEmail: AppTextField!
    @IBOutlet private weak var txtfieldPhone: AppTextField!
    @IBOutlet private weak var txtfieldGender: AppTextField!

    @IBOutlet private weak var pickerGender: UIPickerView!
    @IBOutlet private weak var scrollView: UIScrollView!

    private let viewModel = EditProfileVM()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
    }
    
    override func bindViewModel() {
        
        viewModel.validationFailed = { [weak self] message, validationType in
            guard let self = self else { return }
            self.showCancelAlert(message: message)
        }
        
        viewModel.willEditProfile = {
            AppLoader.shared.loader(true)
        }
        
        viewModel.editProfileSuccessful = {[weak self] message in
            AppLoader.shared.loader(false)
            guard let self = self else { return }
            self.showCancelAlert(message: message)
        }
           
        viewModel.editProfileFailed = {[weak self] message in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            self.showCancelAlert(message: message)
        }
        
        viewModel.willLogout = {
            AppLoader.shared.loader(true)
        }
        
        viewModel.logoutSuccessful = {
            AppLoader.shared.loader(false)
        }
    }
    
    @IBAction private func logoutTap(_ sender: UIButton) {
        self.viewModel.logout()
    }
    
    @IBAction private func submitTap(_ sender: UIButton) {
       editProfile()
        navigationController?.popViewController(animated: true)
    }
    
    private func editProfile() {
        viewModel.editProfileWith(firstName: txtfieldFirstName.text ?? "", lastName: txtfieldLastName.text ?? "", email: txtfieldEmail.text ?? "", phone: txtfieldPhone.text ?? "", gender: User.Gender(rawValue: txtfieldGender.text ?? ""), profileImage: nil)
    }
    
    private func setupUI() {
        let user = User.sharedUser
        txtfieldFirstName.text = user?.firstName
        txtfieldLastName.text = user?.lastName
        txtfieldEmail.text = user?.email
        txtfieldPhone.text = user?.phone
        txtfieldGender.text = user?.gender?.rawValue
        
        txtfieldGender.inputView = pickerGender
    }
}


extension EditProfileVC {
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        pickerGender.isHidden = textField != txtfieldGender
        if textField == txtfieldGender {
            adjustContentOffset(textFied: textField, inputViewHeight: pickerGender.frame.height)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtfieldPhone {
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
            nextResponder = txtfieldPhone
        } else if textField == txtfieldPhone {
            nextResponder = txtfieldGender
        }
        nextResponder?.becomeFirstResponder()
        return false
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        resetContentOffset()
    }
}

extension EditProfileVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        User.Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = User.Gender.allCases[row]
        return item.rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = User.Gender.allCases[row]
        txtfieldGender.text = item == .select ? "" : item.rawValue
    }
}

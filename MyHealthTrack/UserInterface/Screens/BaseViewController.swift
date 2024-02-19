
import UIKit

class BaseViewController: UIViewController {

    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindViewModel()
        addApplicationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactivePopSetup(enable: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppLoader.shared.loader(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(UIApplication.didBecomeActiveNotification)
    }

    
    var hideNavigationBar: Bool {
        return true
    }
    
    func bindViewModel() {
        fatalError("Must be purely override this method in base classes")
    }
        
    @IBAction private func backPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension BaseViewController {
    
    func adjustContentOffset(textFied: UIView?,
                             inputViewHeight: CGFloat) {
        
        guard let activeTextField = inputView else { return }
        
        let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
        
        let topOfKeyboard = self.view.frame.height - inputViewHeight
        
        // if the bottom of Textfield is below the top of keyboard, move up
        let shouldMoveViewUp = bottomOfTextField > topOfKeyboard
        
        if(shouldMoveViewUp) {
            let diff = bottomOfTextField - topOfKeyboard + activeTextField.bounds.height
            self.view.frame.origin.y = 0 - diff
        }
    }
    
    func resetContentOffset() {
        self.view.frame.origin.y = 0
    }
}

extension BaseViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}

extension BaseViewController {
    
    private func addApplicationObserver() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(logout), name: .logoutNotification, object: nil)

    }
    
    @objc func applicationDidBecomeActive(_ notification: Notification) {
        // Need to be purely overridden
    }

    @objc func logout(notification: Notification) {
        CoordinatorManager.shared.mainCoordinator?.navigationController.popToRootViewController(animated: true)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        adjustContentOffset(textFied: activeTextField, inputViewHeight: keyboardSize.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        resetContentOffset()
    }
}

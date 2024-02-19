
import UIKit
import Foundation

typealias AlertBlock = ()->()

extension UIViewController {
    
    func showCancelAlert(title: String? = nil, message: String? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (cancel) in
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   okBock: AlertBlock? = nil,
                   cancelBlock: AlertBlock?) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (cancel) in
                okBock?()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (cancel) in
                cancelBlock?()
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func interactivePopSetup(enable: Bool) {
        let viewControllerCount = (self.navigationController?.viewControllers.count ?? 0)
        let inteactiveEnable =  viewControllerCount > 1 && enable
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = inteactiveEnable
//        print("intractive gesture for \(String(describing: self)) enable: \(inteactiveEnable)")
    }
}

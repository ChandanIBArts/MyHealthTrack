

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC //LoginVC.instantiate(fromStoryboard: .main)
        
        if let _ = UserDefaultManager.token {
//            let summaryVC = SummaryTabBarController.instantiate(fromStoryboard: .main)
            let summaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SummaryTabBarController") as! SummaryTabBarController

            navigationController.viewControllers = [loginVC, summaryVC]
        } else {
            self.navigationController.viewControllers = [loginVC]
        }
    }
    
    func gotoLogin() {
        runOnMainThread {
//            let loginVC = LoginVC.instantiate(fromStoryboard: .main)
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController.pushViewController(loginVC, animated: true)
        }
    }
    
    func gotoOTP(email: String) {
        runOnMainThread {
            //let otpVC = OtpVC.instantiate(fromStoryboard: .main)
            let otpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
            otpVC.viewModel.email = email
            self.navigationController.pushViewController(otpVC, animated: true)
        }
    }
    
    func gotoRegister() {
        runOnMainThread {
            // let register = RegisterVC.instantiate(fromStoryboard: .main)
            let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            self.navigationController.pushViewController(registerVC, animated: true)
        }
    }
    
    func gotoEditProfile() {
        runOnMainThread {
            //let editProfile = EditProfileVC.instantiate(fromStoryboard: .main)
            let editProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            self.navigationController.pushViewController(editProfileVC, animated: true)
        }
    }
   
    func gotoSummary() {
        runOnMainThread {
           // let summaryVC = SummaryTabBarController.instantiate(fromStoryboard: .main)
            let summaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SummaryTabBarController") as! SummaryTabBarController
            self.navigationController.pushViewController(summaryVC, animated: true)
        }
    }
}


func runOnMainThread(_ method:@escaping ()->()?) {
    DispatchQueue.main.async {
        method()
    }
}


import UIKit

class SummaryTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        intractiveGestur(enable: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        intractiveGestur(enable: false)
    }
    
    func intractiveGestur(enable: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
  
    private func initialSetup() {
        self.tabBar.unselectedItemTintColor = UIColor(red: 63/255, green: 61/255, blue: 86/255, alpha: 1.0)
        self.tabBar.tintColor = UIColor(red: 37/255, green: 197/255, blue: 185/255, alpha: 1.0)
    }
}

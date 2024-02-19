
import Foundation

class AppLoader {
    static let shared = AppLoader()
    
    private let loader = ProgressHUD()
   
    private init() {
        loader.animationType = .activityIndicator
        loader.colorHUD = .projectGreen
    }
    
    func loader(_ show: Bool) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            show ? self.loader.animate(text: nil, interaction: false) : self.loader.dismissHUD()
        }
    }
}

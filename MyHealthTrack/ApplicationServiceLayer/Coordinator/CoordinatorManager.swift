//
//  CoordinatorManager.swift
//  MVVMSample
//
//  Created by Deepak Saxena on 05/09/22.
//

import Foundation
import UIKit

class CoordinatorManager {
    
    static let shared = CoordinatorManager()
    
    private(set) var mainCoordinator: AppCoordinator?

    func setupMainCoordinator() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let window = appdelegate.window ?? UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        
        mainCoordinator = AppCoordinator(navCon: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        mainCoordinator?.start()

    }
}

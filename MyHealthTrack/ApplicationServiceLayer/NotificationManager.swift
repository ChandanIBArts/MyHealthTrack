
import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() { }
    
    func sendLogoutNotification() {
        runOnMainThread {
            NotificationCenter.default.post(name: .logoutNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let logoutNotification = Notification.Name("logoutNotification")
}

extension NSNotification {
    static let logoutNotification = Notification.Name.logoutNotification
}

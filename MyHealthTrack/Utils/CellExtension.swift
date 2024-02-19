
import Foundation
import UIKit

protocol ViewIdentifieable {
    
}

extension ViewIdentifieable {
    static var viewIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ViewIdentifieable {
    
}

extension UICollectionViewCell: ViewIdentifieable {
    
}

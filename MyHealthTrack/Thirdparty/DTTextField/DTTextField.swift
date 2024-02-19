
import Foundation
import UIKit

public class AppTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 20

    @IBInspectable var leftImage: UIImage? { didSet { updateLeftView() } }
    @IBInspectable var color: UIColor = UIColor.projectDarkGray {
        didSet { updateLeftView() }
    }
    
    func updateLeftView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageContainer = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding * 2 + 20, height: self.frame.height))
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: self.frame.height))
            imageContainer.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageContainer
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }

}

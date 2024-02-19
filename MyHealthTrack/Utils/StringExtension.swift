
import Foundation
import UIKit

extension String {
    
    var trimmed:String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank: Bool {
        self.trimmed.isEmpty
    }
    
    var isValidPhone: Bool {
        return self.count >= 9 && self.count <= 10
    }
    
    var isValidEmail: Bool {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
       return emailPred.evaluate(with: string)
    }
    
    var dottedUnderLineString: NSAttributedString {
        let textRange = NSRange(location: 0, length: self.count)
        let fullStringColor: UIColor = .projectGreen
        let fullStringFont = UIFont.systemFont(ofSize: 18, weight: .regular)

        let attributedText = NSMutableAttributedString(string: self)
        
        attributedText.addAttribute(.underlineStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: textRange)
                

        attributedText.addAttribute(.foregroundColor,
                                      value: fullStringColor,
                                      range: textRange)

        attributedText.addAttribute(.font,
                                      value: fullStringFont,
                                      range: textRange)


        return attributedText
    }
}

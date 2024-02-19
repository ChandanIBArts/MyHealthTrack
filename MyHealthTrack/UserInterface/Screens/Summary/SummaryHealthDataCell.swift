
import UIKit

class SummaryHealthDataCell: UITableViewCell {

    @IBOutlet private weak var imgViewLeft: UIImageView!
    @IBOutlet private weak var imgViewArrow: UIImageView!
    @IBOutlet private weak var lblItem: UILabel!
    @IBOutlet private weak var lblValueWithUnit: UILabel!
    @IBOutlet private weak var lblTime: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(item: SummaryItem, value: String, time: String?) {
        
        self.imgViewLeft.image = item.itemImage
        self.lblItem.text = item.itemTitle
        self.lblItem.textColor = item.itemTitleColor
        self.lblTime.text = time
        
        lblValueWithUnit.attributedText = setupAttributed(value: value, unit: item.itemUnit)
    }
    
    private func setupAttributed(value: String, unit: String) -> NSAttributedString {
        let fullString = value + " " + unit
        let subString = unit
        let range = (fullString as NSString).range(of: subString)
        
        let fullStringColor: UIColor = .black
        let subStringColor: UIColor = .projectDarkGray
        
        let fullStringFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let subStringFont = UIFont.systemFont(ofSize: 15, weight: .regular)

        let attributedString = NSMutableAttributedString(string:fullString)
        
        // Setup full string color and font
        attributedString.addAttribute(.foregroundColor,
                                      value: fullStringColor,
                                      range: NSRange(location: 0, length: fullString.count))
        attributedString.addAttribute(.font,
                                      value: fullStringFont,
                                      range: NSRange(location: 0, length: fullString.count))

        // Setup Sub string color and font
        attributedString.addAttribute(.foregroundColor,
                                      value: subStringColor,
                                      range: range)
        attributedString.addAttribute(.font,
                                      value: subStringFont,
                                      range: range)
        return attributedString
    }

}

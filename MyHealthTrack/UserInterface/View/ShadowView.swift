
import UIKit

@IBDesignable class ShadowView: UIView {

  @IBInspectable var shadowColor: UIColor = .gray {
    didSet{
      setupAppearance()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAppearance()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupAppearance()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupAppearance()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupAppearance()
  }
  
  private func setupAppearance() {
      layer.shadowColor = UIColor.projectDarkGray.cgColor
      layer.shadowOpacity = 0.20
      layer.shadowRadius = 8
      layer.shadowOffset = .zero//CGSize(width: 1, height: 0)
      layer.cornerRadius = 8
  }
}
